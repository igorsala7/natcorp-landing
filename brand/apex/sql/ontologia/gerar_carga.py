"""Gera o 07_carga.sql (ajustes, pesos, vocabulário e a ONTOLOGIA INICIAL) a partir das listas abaixo.

    python3 gerar_carga.py

Por que um gerador: os nomes têm acento e o .sql precisa sair só com ASCII (unistr) para não
depender da configuração de idioma do cliente que roda o script. Também confere se dois conceitos
disputam o mesmo termo (o que deixaria a classificação ambígua) e para com erro se acontecer.

PODE MEXER: CONFIG, PESOS, ORIGENS, PALAVRAS_FRACAS, ABREVIACOES e CONCEITOS.
Cada conceito: (tipo, nome, "outros nomes; separados; por ponto e vírgula", "nome do conceito mais amplo" ou None)
Tipos: FORMACAO, CURSO, CONHECIMENTO, OCUPACAO, AREA. RELACOES: (conceito, conceito, peso 0-1).
"""
import os
import re
import unicodedata

AQUI = os.path.dirname(os.path.abspath(__file__))

CONFIG = [
    ('RAIO_IDEAL_KM', '10', 'Até esta distância (km, já com o fator de rota) a nota de distância é cheia'),
    ('RAIO_MAXIMO_KM', '60', 'A partir desta distância (km) a nota de distância é zero; entre os dois, cai em linha reta'),
    ('FATOR_ROTA', '1.25', 'Linha reta × fator = estimativa do caminho por ruas'),
    ('MODALIDADES_SEM_DISTANCIA', 'H,T', 'Códigos de TIPO_MODALIDADE em que a distância NÃO conta (H home office, T teletrabalho)'),
    ('MODALIDADES_PARCIAIS', 'S', 'Modalidades em que a distância conta com peso reduzido (S semipresencial)'),
    ('FATOR_PARCIAL', '0.5', 'Multiplica o peso da distância nas modalidades parciais'),
    ('DISTANCIA_SEM_DADO', 'NEUTRO', 'Candidato sem endereço reconhecido: NEUTRO (não conta) ou ZERO (nota zero)'),
    ('PCD_MODO', 'ELIMINATORIO', 'Vaga PCD: ELIMINATORIO (quem não é PCD vai para o fim, marcado) ou PESO (só perde pontos)'),
    ('PCD_TIPO_DIFERENTE', '0.5', 'Nota do candidato PCD cujo tipo de deficiência não é um dos marcados na vaga'),
    ('FATOR_AMPLO', '0.5', 'Candidato tem o conceito MAIS AMPLO que o pedido (Engenharia para Engenharia Civil)'),
    ('FATOR_NAO_CONCLUIDO', '0.5', 'Formação ou curso não concluído vale esta fração'),
    ('FATOR_NIVEL_ABAIXO', '0.6', 'Habilidade com nível abaixo do pedido vale esta fração'),
    ('INSTRUCAO_UM_ABAIXO', '0.5', 'Instrução um degrau abaixo da pedida vale esta fração'),
    ('IDIOMA_NIVEL_ABAIXO', '0.5', 'Idioma com nível abaixo do pedido vale esta fração'),
    ('SALARIO_TOLERANCIA', '0.2', 'Pretensão até este percentual acima do teto da vaga ainda pontua (cai até zero)'),
    ('STATUS_EXCLUIDOS', 'R', 'STATUS_CANDIDATO que não entram no cálculo (R reprovado), separados por vírgula'),
    ('EXP_NEC_USAR', 'N', 'S: as linhas do campo "Experiência necessária" reconhecidas como conceito viram requisitos desejáveis'),
    ('PENDENTE_MIN_CARACTERES', '4', 'Textos menores que isso não vão para a fila de curadoria'),
]

PESOS = [  # critério, peso exigido, peso desejável, descrição
    ('INSTRUCAO', 3, 3, 'Grau de instrução da requisição (sempre exigido)'),
    ('FORMACAO', 3, 1, 'Formações da requisição'),
    ('CURSO', 2, 1, 'Cursos da requisição'),
    ('CONHECIMENTO', 3, 1, 'Conhecimentos da requisição (com nível)'),
    ('EXPERIENCIA', 3, 1, 'Experiências da requisição'),
    ('TEMPO', 2, 2, 'Tempo de serviço pedido (anos e meses)'),
    ('IDIOMA', 3, 1, 'Idiomas da requisição (com nível)'),
    ('DISTANCIA', 2, 2, 'Distância casa-trabalho (não conta em home office)'),
    ('PCD', 5, 5, 'Vaga PCD'),
    ('CARGO_PRETENDIDO', 1, 1, 'O candidato indicou este cargo'),
    ('LOCAL_PRETENDIDO', 1, 1, 'O candidato indicou este local de trabalho'),
    ('SALARIO', 1, 1, 'Pretensão salarial dentro da faixa'),
]

ORIGENS = {  # em quais linhas do cadastro cada critério procura
    'FORMACAO': ['FORMACAO', 'OBS_FORMACAO'],
    'CURSO': ['CURSO', 'OBS_CURSO', 'FORMACAO', 'OBS_FORMACAO'],
    'CONHECIMENTO': ['HABILIDADE', 'OBS_HABILIDADE', 'CURSO', 'OBS_CURSO', 'FORMACAO', 'OBS_FORMACAO', 'EMPREGO', 'QUALIF'],
    'EXPERIENCIA': ['EMPREGO', 'QUALIF'],
}

PALAVRAS_FRACAS = ('de da do das dos e em para com a o as os na no nas nos ao aos um uma por pela pelo pelas pelos '
                   'que ou sobre ate entre sem area curso conhecimento experiencia nivel basico intermediario '
                   'avancado completo completa incompleto incompleta concluido concluida cursando ensino').split()

ABREVIACOES = [('an', 'analista'), ('op', 'operador'), ('ass', 'assistente'), ('jr', 'junior'),
               ('sr', 'senior'), ('pl', 'pleno')]

A, F, C, K, O = 'AREA', 'FORMACAO', 'CURSO', 'CONHECIMENTO', 'OCUPACAO'
CONCEITOS = [
    # ── áreas (os "mais amplos") ────────────────────────────────────────────────────────
    (A, 'Engenharia', '', None),
    (A, 'Tecnologia da Informação', 'TI; T.I.; Informática', None),   # 'Tecnologia' sozinha pegava 'Tecnologia em Logística'
    (A, 'Saúde', 'Área da saúde', None),
    (A, 'Educação', 'Docência; Ensino e educação', None),
    (A, 'Rotinas Administrativas', 'Administrativo; Serviços administrativos; Apoio administrativo', None),
    (A, 'Departamento Pessoal', 'DP; Depto Pessoal; Dep Pessoal; Rotinas de departamento pessoal; Rotinas de DP; Administração de pessoal', None),
    (A, 'Atendimento ao Cliente', 'Atendimento ao público; SAC; Customer service; Relacionamento com o cliente; Atendimento', None),
    (A, 'Vendas', 'Comercial; Técnicas de vendas; Área comercial', None),
    (A, 'Compras', 'Suprimentos; Procurement', None),
    (A, 'Produção Industrial', 'Produção; Linha de produção; Chão de fábrica; Indústria', None),
    (A, 'Manutenção', 'Manutenção industrial; Manutenção predial', None),
    (A, 'Limpeza e Conservação', 'Serviços gerais; Conservação; Limpeza', None),
    (A, 'Segurança Patrimonial', 'Vigilância; Portaria', None),
    (A, 'Cozinha e Alimentação', 'Alimentação; Cozinha; Food service', None),
    (A, 'Gestão de Equipes', 'Liderança; Liderança de equipe; Gestão de pessoas e equipes', None),
    (A, 'Segurança do Trabalho', 'SST; Saúde e segurança do trabalho', None),
    # ── formações ───────────────────────────────────────────────────────────────────────
    (F, 'Administração', 'Administração de Empresas; Administração Empresarial; Gestão Empresarial; Administrador; Administrador de Empresas', None),
    (F, 'Gestão de Recursos Humanos', 'Recursos Humanos; RH; Gestão de Pessoas; Gestão de RH; Administração de Recursos Humanos; Gestão Estratégica de Pessoas; Desenvolvimento Humano', None),
    (F, 'Ciências Contábeis', 'Contabilidade; Contábeis; Contador', None),
    (F, 'Economia', 'Ciências Econômicas; Economista', None),
    (F, 'Direito', 'Ciências Jurídicas; Advogado; Bacharel em Direito', None),
    (F, 'Psicologia', 'Psicólogo; Psicóloga', None),
    (F, 'Gestão Financeira', 'Finanças; Financeiro; Gestão de Finanças', None),
    (F, 'Gestão Comercial', 'Gestão de Vendas', None),
    (F, 'Processos Gerenciais', 'Gestão de Processos Gerenciais', None),
    (F, 'Logística', 'Gestão Logística; Supply Chain; Cadeia de Suprimentos', None),
    (F, 'Marketing', 'Gestão de Marketing; Marketing Digital', None),
    (F, 'Publicidade e Propaganda', 'Publicidade; Propaganda', None),
    (F, 'Comunicação Social', 'Jornalismo; Relações Públicas', None),   # 'Comunicação' sozinha é habilidade, não curso
    (F, 'Comércio Exterior', 'Comex; Relações Internacionais', None),
    (F, 'Secretariado Executivo', 'Secretariado; Secretária Executiva', None),
    (F, 'Gestão da Qualidade', 'Qualidade; Controle de Qualidade; Garantia da Qualidade', None),
    (F, 'Gestão Pública', 'Administração Pública', None),
    (F, 'Gestão Hospitalar', 'Administração Hospitalar', None),
    (F, 'Serviço Social', 'Assistente Social', None),
    (F, 'Pedagogia', 'Pedagogo; Pedagoga', 'Educação'),
    (F, 'Letras', 'Licenciatura em Letras', 'Educação'),
    (F, 'Matemática', 'Licenciatura em Matemática', 'Educação'),
    (F, 'Educação Física', 'Profissional de Educação Física', 'Saúde'),
    (F, 'Estatística', 'Estatístico', None),
    (F, 'Química', 'Químico; Química Industrial', None),
    (F, 'Ciências Biológicas', 'Biologia; Biólogo', None),
    (F, 'Arquitetura e Urbanismo', 'Arquitetura; Arquiteto', None),
    (F, 'Design', 'Design Gráfico; Desenho Industrial; Designer; Designer Gráfico', None),
    (F, 'Turismo e Hotelaria', 'Turismo; Hotelaria', None),
    (F, 'Gastronomia', 'Chef de cozinha', 'Cozinha e Alimentação'),
    (F, 'Enfermagem', 'Enfermeiro; Enfermeira', 'Saúde'),
    (F, 'Medicina', 'Médico; Médica', 'Saúde'),
    (F, 'Nutrição', 'Nutricionista', 'Saúde'),
    (F, 'Fisioterapia', 'Fisioterapeuta', 'Saúde'),
    (F, 'Farmácia', 'Farmacêutico; Farmacêutica', 'Saúde'),
    (F, 'Biomedicina', 'Biomédico; Biomédica', 'Saúde'),
    (F, 'Odontologia', 'Dentista; Cirurgião-dentista', 'Saúde'),
    (F, 'Fonoaudiologia', 'Fonoaudiólogo', 'Saúde'),
    (F, 'Radiologia', 'Tecnólogo em Radiologia; Técnico em Radiologia', 'Saúde'),
    (F, 'Engenharia Civil', 'Engenheiro Civil; Engenheira Civil', 'Engenharia'),
    (F, 'Engenharia de Produção', 'Engenheiro de Produção', 'Engenharia'),
    (F, 'Engenharia Mecânica', 'Engenheiro Mecânico', 'Engenharia'),
    (F, 'Engenharia Elétrica', 'Engenheiro Eletricista; Engenheiro Elétrico', 'Engenharia'),
    (F, 'Engenharia Química', 'Engenheiro Químico', 'Engenharia'),
    (F, 'Engenharia Ambiental', 'Engenheiro Ambiental; Gestão Ambiental', 'Engenharia'),
    (F, 'Engenharia de Segurança do Trabalho', 'Engenheiro de Segurança do Trabalho', 'Segurança do Trabalho'),
    (F, 'Engenharia de Computação', 'Engenheiro de Computação', 'Tecnologia da Informação'),
    (F, 'Engenharia de Software', 'Engenheiro de Software', 'Tecnologia da Informação'),
    (F, 'Ciência da Computação', 'Ciências da Computação; Computação', 'Tecnologia da Informação'),
    (F, 'Sistemas de Informação', 'Sistema de Informação', 'Tecnologia da Informação'),
    (F, 'Análise e Desenvolvimento de Sistemas', 'ADS; Tecnólogo em Análise e Desenvolvimento de Sistemas; Desenvolvimento de Sistemas', 'Tecnologia da Informação'),
    (F, 'Redes de Computadores', 'Infraestrutura de Redes; Redes e Telecomunicações', 'Tecnologia da Informação'),   # 'Redes' pegava 'redes sociais'
    (F, 'Gestão da Tecnologia da Informação', 'Gestão de TI', 'Tecnologia da Informação'),
    (F, 'Banco de Dados', 'Bancos de Dados; Administração de Banco de Dados; DBA', 'Tecnologia da Informação'),
    (F, 'Segurança da Informação', 'Cibersegurança; Segurança Cibernética', 'Tecnologia da Informação'),
    (F, 'Técnico em Enfermagem', 'Técnico de Enfermagem; Técnica de Enfermagem; Técnica em Enfermagem', 'Saúde'),
    (F, 'Técnico em Segurança do Trabalho', 'Técnico de Segurança do Trabalho; Técnica em Segurança do Trabalho; TST', 'Segurança do Trabalho'),
    (F, 'Técnico em Administração', 'Técnica em Administração', None),
    (F, 'Técnico em Contabilidade', 'Técnico Contábil', None),
    (F, 'Técnico em Logística', 'Técnica em Logística', None),
    (F, 'Técnico em Informática', 'Técnico de Informática; Técnico em TI', 'Tecnologia da Informação'),
    (F, 'Técnico em Recursos Humanos', 'Técnico em RH', None),
    (F, 'Eletrotécnica', 'Técnico em Eletrotécnica; Técnico Eletrotécnico', None),
    (F, 'Eletrônica', 'Técnico em Eletrônica', None),
    (F, 'Mecânica', 'Técnico em Mecânica; Mecânica Industrial', None),
    (F, 'Mecatrônica', 'Técnico em Mecatrônica; Engenharia Mecatrônica', None),
    (F, 'Edificações', 'Técnico em Edificações', None),
    # ── ocupações (experiência) ─────────────────────────────────────────────────────────
    (O, 'Analista de Negócios', 'Business Analyst; Analista de Negócio; Business Partner', None),
    (O, 'Analista de Sistemas', 'Analista de Desenvolvimento de Sistemas', 'Tecnologia da Informação'),
    (O, 'Desenvolvedor de Software', 'Desenvolvedor; Programador; Developer; Desenvolvedora; Programadora', 'Tecnologia da Informação'),
    (O, 'Analista de Suporte', 'Suporte Técnico; Help Desk; Service Desk; Técnico de Suporte; Suporte de TI', 'Tecnologia da Informação'),
    (O, 'Analista de Dados', 'Data Analyst; Analista de BI; Business Intelligence; Analista de Business Intelligence', 'Tecnologia da Informação'),
    (O, 'Cientista de Dados', 'Data Scientist; Ciência de Dados', 'Tecnologia da Informação'),
    (O, 'Analista de Recursos Humanos', 'Analista de RH', 'Gestão de Recursos Humanos'),
    (O, 'Assistente de Recursos Humanos', 'Assistente de RH; Auxiliar de RH; Auxiliar de Recursos Humanos', 'Gestão de Recursos Humanos'),
    (O, 'Analista de Recrutamento e Seleção', 'Recrutamento e Seleção; Recrutador; Recrutadora; Tech Recruiter; Analista de Recrutamento', 'Gestão de Recursos Humanos'),
    (O, 'Analista de Departamento Pessoal', 'Analista de DP', 'Departamento Pessoal'),
    (O, 'Assistente de Departamento Pessoal', 'Assistente de DP; Auxiliar de Departamento Pessoal; Auxiliar de DP', 'Departamento Pessoal'),
    (O, 'Assistente Administrativo', 'Assistente Administrativa; Agente Administrativo', 'Rotinas Administrativas'),
    (O, 'Auxiliar Administrativo', 'Auxiliar Administrativa; Auxiliar de Escritório', 'Rotinas Administrativas'),
    (O, 'Recepcionista', 'Recepção', 'Atendimento ao Cliente'),
    (O, 'Atendente', 'Atendente de SAC; Atendente de Loja; Atendente de Balcão', 'Atendimento ao Cliente'),
    (O, 'Operador de Telemarketing', 'Telemarketing; Teleatendimento; Call Center; Operador de Teleatendimento; Central de Atendimento', 'Atendimento ao Cliente'),
    (O, 'Operador de Caixa', 'Caixa de Loja; Operadora de Caixa', 'Atendimento ao Cliente'),
    (O, 'Vendedor', 'Vendedora; Consultor de Vendas; Consultora de Vendas; Vendedor Externo; Vendedor Interno', 'Vendas'),
    (O, 'Representante Comercial', 'Representante de Vendas; Executivo de Vendas; Executivo de Contas; Key Account', 'Vendas'),
    (O, 'Promotor de Vendas', 'Promotora de Vendas; Promotor de Merchandising; Repositor', 'Vendas'),
    (O, 'Comprador', 'Analista de Compras; Assistente de Compras; Compradora', 'Compras'),
    (O, 'Almoxarife', 'Auxiliar de Almoxarifado; Almoxarifado', 'Logística'),
    (O, 'Estoquista', 'Auxiliar de Estoque; Controle de Estoque; Gestão de Estoque; Inventário', 'Logística'),
    (O, 'Conferente', 'Conferente de Mercadorias; Conferente de Carga', 'Logística'),
    (O, 'Operador de Empilhadeira', 'Empilhadeira; Empilhadeirista; NR11; Movimentação de Cargas', 'Logística'),
    (O, 'Auxiliar de Logística', 'Assistente de Logística; Analista de Logística', 'Logística'),
    (O, 'Motorista', 'Condutor', None),
    (O, 'Motorista de Caminhão', 'Caminhoneiro; Carreteiro; Motorista Carreteiro', 'Motorista'),
    (O, 'Motorista Entregador', 'Entregador; Motoboy; Motofretista', 'Motorista'),
    (O, 'Auxiliar de Limpeza', 'Faxineiro; Faxineira; Auxiliar de Serviços Gerais; Zelador; Zeladora; Copeiro; Copeira', 'Limpeza e Conservação'),
    (O, 'Porteiro', 'Porteira; Controlador de Acesso; Recepcionista de Portaria', 'Segurança Patrimonial'),
    (O, 'Vigilante', 'Vigia; Agente de Segurança', 'Segurança Patrimonial'),
    (O, 'Analista Contábil', 'Assistente Contábil; Auxiliar Contábil; Auxiliar de Contabilidade', 'Ciências Contábeis'),
    (O, 'Analista Fiscal', 'Assistente Fiscal; Escrita Fiscal; Rotinas Fiscais; Apuração de Impostos', 'Ciências Contábeis'),
    (O, 'Analista Financeiro', 'Assistente Financeiro; Auxiliar Financeiro; Contas a Pagar; Contas a Receber; Tesouraria; Tesoureiro; Faturamento', 'Gestão Financeira'),
    (O, 'Auxiliar de Produção', 'Operador de Produção; Ajudante de Produção; Auxiliar de Linha de Produção; Ajudante Geral', 'Produção Industrial'),
    (O, 'Operador de Máquinas', 'Operador de Máquina; Operador de Injetora; Operador de Prensa', 'Produção Industrial'),
    (O, 'Montador', 'Montador de Produção; Montadora', 'Produção Industrial'),
    (O, 'Eletricista', 'Eletricista de Manutenção; Eletricista Predial; Eletricista Industrial', 'Manutenção'),
    (O, 'Mecânico', 'Mecânico de Manutenção; Mecânico Industrial', 'Manutenção'),
    (O, 'Técnico de Manutenção', 'Técnico em Manutenção; Auxiliar de Manutenção', 'Manutenção'),
    (O, 'Soldador', 'Solda; Soldagem', 'Produção Industrial'),
    (O, 'Pedreiro', 'Ajudante de Pedreiro; Servente de Obras', None),
    (O, 'Cozinheiro', 'Cozinheira; Auxiliar de Cozinha; Ajudante de Cozinha; Chefe de Cozinha', 'Cozinha e Alimentação'),
    (O, 'Garçom', 'Garçonete', 'Cozinha e Alimentação'),
    (O, 'Padeiro', 'Confeiteiro; Confeiteira', 'Cozinha e Alimentação'),
    (O, 'Professor', 'Professora; Docente; Instrutor; Instrutora', 'Educação'),
    (O, 'Analista de Marketing', 'Assistente de Marketing; Social Media; Analista de Mídias Sociais; Mídias Sociais', 'Marketing'),
    (O, 'Designer de UX', 'UX Designer; UI Designer; UX/UI; Designer de Interfaces; Product Designer', 'Design'),
    (O, 'Assistente Jurídico', 'Auxiliar Jurídico; Paralegal', 'Direito'),
    (O, 'Supervisor', 'Supervisora', 'Gestão de Equipes'),
    (O, 'Coordenador', 'Coordenadora', 'Gestão de Equipes'),
    (O, 'Gerente', 'Gerente de Área; Gestor; Gestora', 'Gestão de Equipes'),
    (O, 'Jovem Aprendiz', 'Aprendiz; Menor Aprendiz', None),
    (O, 'Estagiário', 'Estagiária; Estágio', None),
    (O, 'Trainee', 'Programa de Trainee', None),
    # ── conhecimentos ───────────────────────────────────────────────────────────────────
    (K, 'Pacote Office', 'MS Office; Microsoft Office; Office 365', None),   # 'Office' sozinho pegava 'home office'
    (K, 'Excel', 'Microsoft Excel; MS Excel; Planilhas Excel', None),
    (K, 'Word', 'Microsoft Word; MS Word', None),
    (K, 'PowerPoint', 'Power Point; Microsoft PowerPoint', None),
    (K, 'Power BI', 'PowerBI', 'Tecnologia da Informação'),
    (K, 'SQL', 'Linguagem SQL; PL/SQL; T-SQL; SQL Server', 'Tecnologia da Informação'),
    (K, 'Oracle', 'Banco de Dados Oracle; Oracle Database', 'Tecnologia da Informação'),
    (K, 'Oracle APEX', 'APEX; Application Express', 'Tecnologia da Informação'),
    (K, 'Python', '', 'Tecnologia da Informação'),
    (K, 'Java', 'Linguagem Java', 'Tecnologia da Informação'),
    (K, 'JavaScript', 'JS; Node; NodeJS; TypeScript', 'Tecnologia da Informação'),
    (K, 'C#', '.NET; Dotnet; ASP.NET', 'Tecnologia da Informação'),
    (K, 'PHP', '', 'Tecnologia da Informação'),
    (K, 'Computação em Nuvem', 'Cloud; AWS; Azure; Google Cloud', 'Tecnologia da Informação'),
    (K, 'Linux', '', 'Tecnologia da Informação'),
    (K, 'Git', 'GitHub; GitLab', 'Tecnologia da Informação'),
    (K, 'SAP', 'ERP SAP', None),
    (K, 'TOTVS', 'Protheus; Datasul; TOTVS RM', None),
    (K, 'Salesforce', 'CRM Salesforce', None),
    (K, 'AutoCAD', 'Auto CAD; CAD', None),
    (K, 'Photoshop', 'Adobe Photoshop', None),
    (K, 'Illustrator', 'Adobe Illustrator', None),
    (K, 'Figma', '', None),
    (K, 'Folha de Pagamento', 'Folha; Cálculo de Folha; Processamento de Folha', 'Departamento Pessoal'),
    (K, 'eSocial', 'e-Social', 'Departamento Pessoal'),
    (K, 'Legislação Trabalhista', 'CLT; Direito do Trabalho', None),
    (K, 'Admissão e Demissão', 'Admissões e Desligamentos; Rotinas de Admissão; Rescisão', 'Departamento Pessoal'),
    (K, 'Benefícios', 'Gestão de Benefícios; Administração de Benefícios', 'Departamento Pessoal'),
    (K, 'Negociação', 'Técnicas de Negociação', None),
    (K, 'Gestão de Projetos', 'PMP; PMBOK; Gerenciamento de Projetos', None),
    (K, 'Metodologias Ágeis', 'Scrum; Kanban; Agile; Ágil', None),
    (K, 'Lean Six Sigma', 'Lean; Six Sigma; Seis Sigma; Green Belt; Yellow Belt; Black Belt', 'Gestão da Qualidade'),
    (K, 'ISO 9001', 'Norma ISO 9001', 'Gestão da Qualidade'),
    (K, 'LGPD', 'Lei Geral de Proteção de Dados; Proteção de Dados', None),
    (K, 'Primeiros Socorros', '', None),
    (K, 'Brigada de Incêndio', 'Brigadista; Combate a Incêndio', None),
    (K, 'NR-10', 'NR10; Segurança em Instalações Elétricas', 'Segurança do Trabalho'),
    (K, 'NR-12', 'NR12; Segurança em Máquinas e Equipamentos', 'Segurança do Trabalho'),
    (K, 'NR-33', 'NR33; Espaço Confinado', 'Segurança do Trabalho'),
    (K, 'NR-35', 'NR35; Trabalho em Altura', 'Segurança do Trabalho'),
]

RELACOES = [  # relacionados (valem o peso um pelo outro, nos dois sentidos)
    ('Gestão de Recursos Humanos', 'Administração', 0.5),
    ('Gestão de Recursos Humanos', 'Psicologia', 0.3),
    ('Gestão de Recursos Humanos', 'Departamento Pessoal', 0.5),
    ('Gestão Financeira', 'Administração', 0.5),
    ('Gestão Financeira', 'Economia', 0.4),
    ('Gestão Financeira', 'Ciências Contábeis', 0.4),
    ('Gestão Comercial', 'Administração', 0.5),
    ('Gestão Comercial', 'Marketing', 0.3),
    ('Processos Gerenciais', 'Administração', 0.6),
    ('Logística', 'Administração', 0.3),
    ('Marketing', 'Publicidade e Propaganda', 0.5),
    ('Marketing', 'Comunicação Social', 0.4),
    ('Publicidade e Propaganda', 'Comunicação Social', 0.5),
    ('Gestão Pública', 'Administração', 0.5),
    ('Gestão Hospitalar', 'Administração', 0.4),
    ('Técnico em Administração', 'Administração', 0.4),
    ('Técnico em Contabilidade', 'Ciências Contábeis', 0.4),
    ('Técnico em Logística', 'Logística', 0.5),
    ('Técnico em Recursos Humanos', 'Gestão de Recursos Humanos', 0.5),
    ('Técnico em Enfermagem', 'Enfermagem', 0.3),
    ('Eletrotécnica', 'Engenharia Elétrica', 0.3),
    ('Mecânica', 'Engenharia Mecânica', 0.3),
    ('Edificações', 'Engenharia Civil', 0.3),
    ('Sistemas de Informação', 'Ciência da Computação', 0.7),
    ('Análise e Desenvolvimento de Sistemas', 'Sistemas de Informação', 0.7),
    ('Análise e Desenvolvimento de Sistemas', 'Ciência da Computação', 0.6),
    ('Engenharia de Computação', 'Ciência da Computação', 0.7),
    ('Engenharia de Software', 'Ciência da Computação', 0.7),
    ('Analista de Sistemas', 'Desenvolvedor de Software', 0.6),
    ('Analista de Negócios', 'Analista de Sistemas', 0.4),
    ('Analista de Dados', 'Cientista de Dados', 0.6),
    ('Assistente Administrativo', 'Auxiliar Administrativo', 0.7),
    ('Recepcionista', 'Atendente', 0.6),
    ('Operador de Caixa', 'Atendente', 0.5),
    ('Vendedor', 'Representante Comercial', 0.6),
    ('Garçom', 'Atendimento ao Cliente', 0.5),
    ('Pacote Office', 'Excel', 0.7),
    ('Pacote Office', 'Word', 0.7),
    ('Pacote Office', 'PowerPoint', 0.7),
    ('Folha de Pagamento', 'eSocial', 0.4),
    ('Legislação Trabalhista', 'Departamento Pessoal', 0.5),
    ('Analista Financeiro', 'Analista Contábil', 0.4),
    ('Motorista', 'Operador de Empilhadeira', 0.2),
]

# ─────────────────────────────────────────────────────────────────────────────────────────
# TESTES (viram o 09_testes.sql, que roda no banco depois da instalação)
TESTE_CONTEM = [  # (requisito, linha do candidato, 1 = deve casar / 0 = não deve)
    ('Adm. Empresa', 'Administração de Empresas', 1), ('Administração de Empresas', 'Adm. de Empresas', 1),
    ('An. de negócio', 'Analista de Negócios', 1), ('Analista de Negócios', 'An. de negócio', 1),
    ('Analista de negócio', 'Analista de Negócios', 1), ('Analista de negócios', 'Analista de Negócio', 1),
    ('Engenharia Civil', 'Eng. Civil', 1), ('Aux. Administrativo', 'Auxiliar administrativo', 1),
    ('An. de negócio', 'Técnico em análises clínicas', 0), ('Excel', 'Excel avançado', 1),
    ('Engenheiro Civil', 'Eng. Civil', 1), ('Administração', 'Adminstração', 1),
    ('Direito', 'Administração de Empresas', 0), ('Técnico em Enfermagem', 'Tecnologia em Logística', 0),
    ('Auxiliar Administrativo', 'Administração de Empresas', 0), ('Excel', 'Excelente comunicação', 0),
    ('Java', 'JavaScript', 0), ('NR-35', 'Curso NR 35 trabalho em altura', 1), ('PL/SQL', 'pl sql avançado', 1),
]
TESTE_CLASSIFICAR = [  # (texto, conceito esperado)
    ('Adm. de Empresas', 'Administração'), ('Gestão de RH', 'Gestão de Recursos Humanos'),
    ('Analista de negócios', 'Analista de Negócios'), ('An. de Negócios', 'Analista de Negócios'),
    ('Eng. Civil', 'Engenharia Civil'), ('Técnica de Enfermagem', 'Técnico em Enfermagem'),
    ('MBA em Gestão de Pessoas', 'Gestão de Recursos Humanos'), ('NR-35', 'NR-35'),
    ('Curso de NR 35 - Trabalho em altura', 'NR-35'), ('PL/SQL', 'SQL'), ('Vendedor externo', 'Vendedor'),
    ('Auxiliar adm.', 'Auxiliar Administrativo'), ('Assistente de DP', 'Assistente de Departamento Pessoal'),
    ('Rotinas de DP e folha', 'Departamento Pessoal'), ('T.I.', 'Tecnologia da Informação'),
    ('Engenharia Mecânica', 'Engenharia Mecânica'), ('Java e Spring', 'Java'), ('Node.js', 'JavaScript'),
    ('Operadora de caixa', 'Operador de Caixa'), ('Enfermeira', 'Enfermagem'),
    ('Tecnologia em Logística', 'Logística'), ('Analista Contábil Pleno', 'Analista Contábil'),
    ('R.H.', 'Gestão de Recursos Humanos'),
]
TESTE_NAO_CLASSIFICAR = [  # (texto, conceito que NÃO pode sair)
    ('Excelente comunicação e liderança', 'Excel'), ('Trabalho em home office', 'Pacote Office'),
    ('Gestão de redes sociais', 'Redes de Computadores'), ('Tecnologia em Logística', 'Tecnologia da Informação'),
    ('Analista de sistemas', 'Analista de Negócios'),
]
TESTE_AMPLO = [('Engenharia Civil', 'Engenharia'), ('Vendedor', 'Vendas'), ('Analista de Departamento Pessoal', 'Departamento Pessoal'),
               ('Técnico em Segurança do Trabalho', 'Segurança do Trabalho')]


def gerar_testes():
    L = ["""/* +========================================================================================+
   |  ONTOLOGIA DE RECRUTAMENTO - 09  TESTES (depois do 07; nao altera dados)                  |
   +========================================================================================+
   GERADO por gerar_carga.py. Imprime OK/FALHA por caso e termina com ERRO se houver falha.
   Os mesmos casos foram conferidos fora do banco (espelho em Python) antes da entrega.
*/
set define off
set serveroutput on size unlimited
declare
  n_ok number := 0; n_falha number := 0;
  v varchar2(200);
  d number;
  a number;
  b number;
  procedure conferir (p_ok boolean, p_desc varchar2) is
  begin
    if p_ok then n_ok := n_ok + 1; else n_falha := n_falha + 1; dbms_output.put_line('  FALHA  ' || p_desc); end if;
  end;
  function nome_de (p_id number) return varchar2 is r varchar2(200);
  begin select nome into r from ont_conceito where id = p_id; return r; exception when no_data_found then return null; end;
  function id_de (p varchar2) return number is r number;
  begin select min(id) into r from ont_conceito where upper(nome) = upper(p); return r; end;
  function tem_conceito (p_texto varchar2, p_conceito varchar2) return boolean is
    v_norm varchar2(1000) := ont_texto.normalizar(p_texto);
    v_cid  number := id_de(p_conceito);
    n number;
  begin
    /* a mesma regra de ont_ontologia.classificar_linhas, para TODOS os conceitos do texto */
    select count(*) into n
      from (select tt.termo_id, count(distinct tt.posicao) achou
              from table(ont_texto.tokens(v_norm)) lt
              join ont_termo_token tt on tt.p3 = lt.p3
               and (tt.token = lt.token
                    or (length(lt.token) >= 3 and tt.token like lt.token || '%' and ont_texto.conhecida(lt.token) = 0)
                    or (length(lt.token) >= 6 and length(tt.token) >= 6 and utl_match.edit_distance(lt.token, tt.token) <= 1
                        and ont_texto.conhecida(lt.token) = 0))
             group by tt.termo_id) m
      join ont_termo t on t.id = m.termo_id and m.achou = t.n_tokens
     where t.conceito_id = v_cid;
    return n > 0;
  end;
begin
  ont_ontologia.limpar_cache;
  dbms_output.put_line('== comparar texto (requisito x linha do candidato) ==');"""]
    for req, lin, esp in TESTE_CONTEM:
        L.append("  conferir(ont_texto.contem(ont_texto.normalizar(%s), ont_texto.normalizar(%s)) = %d, %s);"
                 % (u(lin), u(req), esp, u('contem: %s | %s -> esperado %d' % (req, lin, esp))))
    L.append("  dbms_output.put_line('== classificar (conceito mais especifico) ==');")
    for t, esp in TESTE_CLASSIFICAR:
        L.append("  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar(%s)));\n"
                 "  conferir(v = %s, %s || nvl(v, '(nenhum)'));" % (u(t), u(esp), u('classificar: %s -> esperado %s, veio ' % (t, esp))))
    L.append("  dbms_output.put_line('== nao pode reconhecer ==');")
    for t, nao in TESTE_NAO_CLASSIFICAR:
        L.append("  conferir(not tem_conceito(%s, %s), %s);" % (u(t), u(nao), u('nao classificar: %s como %s' % (t, nao))))
    L.append("  dbms_output.put_line('== hierarquia (mais amplo) ==');")
    for a, b in TESTE_AMPLO:
        L.append("  a := id_de(%s); b := id_de(%s);\n"
                 "  select count(*) into d from ont_conceito_fecho where conceito_id = a and ancestral_id = b;\n"
                 "  conferir(d = 1, %s);" % (u(a), u(b), u('fecho: %s e um tipo de %s' % (a, b))))
    L.append("""  dbms_output.put_line('== distancia ==');
  select ont_aderencia.km(s.latitude, s.longitude, o.latitude, o.longitude) into d
    from ont_municipio_geo s, ont_municipio_geo o where s.cod_ibge7 = 3550308 and o.cod_ibge7 = 3552205;
  conferir(d between 75 and 90, 'km Sao Paulo - Sorocaba em linha reta entre 75 e 90 (veio ' || round(d, 1) || ')');
  select ont_aderencia.km(s.latitude, s.longitude, o.latitude, o.longitude) into d
    from ont_municipio_geo s, ont_municipio_geo o where s.cod_ibge7 = 3550308 and o.cod_ibge7 = 3304557;
  conferir(d between 340 and 370, 'km Sao Paulo - Rio de Janeiro em linha reta entre 340 e 370 (veio ' || round(d, 1) || ')');
  select count(*) into d from ont_municipio_geo where nome_norm = 'sao paulo' and uf = 'SP';
  conferir(d = 1, 'municipio Sao Paulo/SP achado pelo nome normalizado');
  dbms_output.put_line('== escalas ==');
  select count(*) into d from ont_instrucao_ordem where ordem is null;
  conferir(d = 0, d || ' grau(s) de instrucao sem ordem - corrigir em ONT_INSTRUCAO_ORDEM');
  select count(*) into d from ont_nivel_ordem where ordem is null;
  conferir(d = 0, d || ' nivel(is) de conhecimento sem ordem - corrigir em ONT_NIVEL_ORDEM');
  dbms_output.put_line(chr(10) || 'RESULTADO: ' || n_ok || ' ok, ' || n_falha || ' falha(s)');
  if n_falha > 0 then raise_application_error(-20199, n_falha || ' teste(s) falharam - veja acima'); end if;
end;
/
""")
    sql = '\n'.join(L)
    open(os.path.join(AQUI, '09_testes.sql'), 'w', encoding='ascii').write(ascii_seguro(sql))
    print('09_testes.sql: %d casos' % (len(TESTE_CONTEM) + len(TESTE_CLASSIFICAR) + len(TESTE_NAO_CLASSIFICAR) + len(TESTE_AMPLO) + 5))


# ─────────────────────────────────────────────────────────────────────────────────────────
# Espelho do ont_texto.normalizar (só para conferir colisões aqui; quem vale é o do banco)
def sem_acento(t):
    return ''.join(c for c in unicodedata.normalize('NFD', t.lower()) if unicodedata.category(c) != 'Mn')

def raiz(w):
    if len(w) <= 3: return w
    for a, b in [('coes$', 'cao'), ('oes$', 'ao'), ('aes$', 'ao'), ('eis$', 'il'), ('ais$', 'al'),
                 ('([rzl])es$', r'\1'), ('([^s])s$', r'\1')]:
        w = re.sub(a, b, w)
    return w

FRACAS = set(PALAVRAS_FRACAS)
ABR = dict(ABREVIACOES)

def normalizar(t):
    t = sem_acento(t)
    for a, b in [('pl/sql', ' plsql '), ('t-sql', ' tsql '), ('c#', ' csharp '), ('c++', ' cplusplus '), ('.net', ' dotnet ')]:
        t = t.replace(a, b)
    t = re.sub(r'(^|[^a-z])nr[ -]?([0-9]+)', r'\1nr\2', t)
    t = re.sub(r'(^|[^a-z])pl[ -]sql', r'\1plsql', t)
    t = re.sub(r'(^|[^a-z])e[ -]social', r'\1esocial', t)
    t = re.sub(r'(^|[^a-z])([a-z])\.([a-z])\.?([^a-z]|$)', r'\1\2\3\4', t)
    t = re.sub(r'[^a-z0-9]+', ' ', t).strip()
    out = []
    for w in t.split():
        if len(w) < 2 or w in FRACAS: continue
        w = raiz(ABR.get(w, w))
        if w not in FRACAS: out.append(w)
    return ' '.join(out)

def ascii_seguro(sql):
    """o que sobrou fora dos literais (comentários, prompts): sem acento e molduras em ASCII"""
    trocas = {'═': '=', '─': '-', '║': '|', '╔': '+', '╗': '+', '╚': '+', '╝': '+', '→': '->', '—': '-', '…': '...'}
    out = ''.join(trocas.get(c, c) for c in sql)
    out = ''.join(c for c in unicodedata.normalize('NFD', out) if unicodedata.category(c) != 'Mn')
    bad = sorted({c for c in out if ord(c) > 127})
    if bad: raise SystemExit('caracteres sem tradução para ASCII: %r' % bad)
    return out


def u(t):
    t = t.replace("'", "''")
    if all(ord(c) < 128 for c in t): return "'" + t + "'"
    return "to_char(unistr('" + ''.join('\\005C' if c == '\\' else (c if ord(c) < 128 else '\\%04X' % ord(c)) for c in t) + "'))"

def conferir():
    nomes = {}
    for tipo, nome, termos, amplo in CONCEITOS:
        if nome.upper() in nomes: raise SystemExit('nome repetido: ' + nome)
        nomes[nome.upper()] = tipo
    for tipo, nome, termos, amplo in CONCEITOS:
        if amplo and amplo.upper() not in nomes: raise SystemExit('amplo inexistente: %s → %s' % (nome, amplo))
    for a, b, p in RELACOES:
        for x in (a, b):
            if x.upper() not in nomes: raise SystemExit('relação com conceito inexistente: ' + x)
    dono = {}
    for tipo, nome, termos, amplo in CONCEITOS:
        for t in [nome] + [x.strip() for x in termos.split(';') if x.strip()]:
            n = normalizar(t)
            if not n: raise SystemExit('termo vazio depois de normalizar: %r (%s)' % (t, nome))
            if n in dono and dono[n] != nome:
                raise SystemExit('termo "%s" (%s) está em "%s" e em "%s"' % (t, n, dono[n], nome))
            dono[n] = nome
    return len(dono)

def gerar():
    n_termos = conferir()
    L = []
    L.append("""/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  ONTOLOGIA DE RECRUTAMENTO — 07  CARGA INICIAL                                            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝
   GERADO por gerar_carga.py — não edite aqui; edite o .py e gere de novo.
   %d conceitos, %d termos, %d relações + o catálogo HABILIDADE da base.
   Rodar de novo é seguro: ajustes e pesos são mesclados (não sobrescreve valor já mudado),
   conceitos/termos existentes são mantidos.
*/
set define off
set serveroutput on size unlimited
""" % (len(CONCEITOS), n_termos, len(RELACOES)))
    L.append('/* ── ajustes (só insere o que não existe: valor já ajustado fica) ── */')
    for k, v, d in CONFIG:
        L.append("merge into ont_config c using (select %s chave, %s valor, %s descricao from dual) x on (c.chave = x.chave)\n"
                 " when matched then update set c.descricao = x.descricao\n"
                 " when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);" % (u(k), u(v), u(d)))
    L.append('\n/* ── pesos (idem) ── */')
    for c, e, d, desc in PESOS:
        L.append("merge into ont_peso p using (select %s criterio, %s pe, %s pd, %s descricao from dual) x on (p.criterio = x.criterio)\n"
                 " when matched then update set p.descricao = x.descricao\n"
                 " when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);"
                 % (u(c), e, d, u(desc)))
    L.append('\n/* ── onde cada critério procura ── */')
    for c, origens in ORIGENS.items():
        for o in origens:
            L.append("insert into ont_criterio_origem (criterio, origem) select '%s', '%s' from dual where not exists "
                     "(select 1 from ont_criterio_origem where criterio = '%s' and origem = '%s');" % (c, o, c, o))
    L.append('\n/* ── palavras fracas e abreviações ── */')
    for w in PALAVRAS_FRACAS:
        L.append("insert into ont_palavra_fraca (palavra) select '%s' from dual where not exists (select 1 from ont_palavra_fraca where palavra = '%s');" % (w, w))
    for a, b in ABREVIACOES:
        L.append("merge into ont_abreviacao x using (select '%s' token, '%s' expansao from dual) y on (x.token = y.token)\n"
                 " when not matched then insert (token, expansao) values (y.token, y.expansao);" % (a, b))
    L.append('commit;')
    L.append("""
/* ── escalas: instrução e nível de conhecimento, lidas das tabelas da base ──
   A ordem sai do NOME (padrão eSocial). Confira o resultado impresso abaixo e corrija à mão o que
   vier vazio ou errado (update ont_instrucao_ordem set ordem = ..., conferido = 'S' where cod = ...). */
merge into ont_instrucao_ordem o
using (select to_char(cod) cod, nome,
              case
                when n like '%doutor%' then 12
                when n like '%mestr%' then 11
                when n like '%pos gradua%' or n like '%posgradua%' or n like '%especializ%' or n like '% mba%' or n like 'mba%' then 10
                when n like '%analfabet%' then 1
                when regexp_like(n, 'ate (o |a )?(4|5)[oa]?( |$)') then 2
                when regexp_like(n, '(4|5)[oa]? (ano|serie)') and n not like '%incomplet%' then 3
                when regexp_like(n, '(5|6)[oa]? (ao|a) (8|9)[oa]?( |$)') then 4
                when (n like '%superior%' or n like '%gradua%' or n like '%bacharel%' or n like '%licenciat%' or n like '%tecnologo%')
                     and n like '%incomplet%' then 8
                when n like '%superior%' or n like '%gradua%' or n like '%bacharel%' or n like '%licenciat%' or n like '%tecnologo%' then 9
                when (n like '%medio%' or n like '%2 grau%' or n like '%segundo grau%' or n like '%colegial%' or n like '%tecnico%')
                     and n like '%incomplet%' then 6
                when n like '%tecnico%' then 7.5
                when n like '%medio%' or n like '%2 grau%' or n like '%segundo grau%' or n like '%colegial%' then 7
                when (n like '%fundamental%' or n like '%1 grau%' or n like '%primeiro grau%' or n like '%ginasi%') and n like '%incomplet%' then 4
                when n like '%fundamental%' or n like '%1 grau%' or n like '%primeiro grau%' or n like '%ginasi%' then 5
              end ordem
         from (select cod, nome, trim(regexp_replace(ont_texto.sem_acento(nome), '[^a-z0-9]+', ' ')) n from instrucao)) x
   on (o.cod = x.cod)
 when matched then update set o.nome = x.nome, o.ordem = case when o.conferido = 'S' then o.ordem else x.ordem end
 when not matched then insert (cod, nome, ordem) values (x.cod, x.nome, x.ordem);

merge into ont_nivel_ordem o
using (select to_char(codigo) codigo, descricao,
              case when n like '%nativ%' then 5 when n like '%fluen%' then 4 when n like '%avanc%' then 3
                   when n like '%intermed%' then 2 when n like '%basic%' then 1 end ordem
         from (select codigo, descricao, ont_texto.sem_acento(descricao) n from nivel_conhecimento)) x
   on (o.codigo = x.codigo)
 when matched then update set o.descricao = x.descricao, o.ordem = case when o.conferido = 'S' then o.ordem else x.ordem end
 when not matched then insert (codigo, descricao, ordem) values (x.codigo, x.descricao, x.ordem);
commit;
""")
    L.append('/* ── conceitos (os mais amplos primeiro) ── */')
    ordem = [c for c in CONCEITOS if not c[3]] + [c for c in CONCEITOS if c[3]]
    for i in range(0, len(ordem), 40):
        L.append('declare v number; begin')
        for tipo, nome, termos, amplo in ordem[i:i + 40]:
            L.append("  v := ont_ontologia.novo_conceito('%s', %s, %s, %s, null, 'CARGA_INICIAL');"
                     % (tipo, u(nome), u(termos) if termos else 'null', u(amplo) if amplo else 'null'))
        L.append('  commit;\nend;\n/')
    L.append('\n/* ── relacionados ── */')
    L.append('declare\n  function id (p varchar2) return number is r number;\n'
             '  begin select min(id) into r from ont_conceito where upper(nome) = upper(p); return r; end;\nbegin')
    for a, b, p in RELACOES:
        L.append("  ont_ontologia.relacionar(id(%s), 'RELACIONADO', id(%s), %s);" % (u(a), u(b), p))
    L.append('  ont_ontologia.recalcular_fecho;\n  commit;\nend;\n/')
    L.append("""
/* ── o catálogo HABILIDADE da base vira conceito CONHECIMENTO (ou termo de um que já existe) ── */
declare
  v_id   number;
  v_norm varchar2(1000);
  n_novo number := 0;
  n_term number := 0;
begin
  for h in (select codigo, descricao from habilidade where descricao is not null) loop
    v_norm := ont_texto.normalizar(h.descricao);
    v_id := case when v_norm is not null then ont_ontologia.classificar_texto(v_norm) end;
    if v_id is not null and exists_termo_exato(v_id, v_norm) = 1 then
      update ont_conceito set cod_externo = nvl(cod_externo, 'HAB:' || h.codigo) where id = v_id;
      n_term := n_term + 1;
    elsif v_norm is not null then
      v_id := ont_ontologia.novo_conceito('CONHECIMENTO', initcap(h.descricao), null, null, 'HAB:' || h.codigo, 'HABILIDADE');
      n_novo := n_novo + 1;
    end if;
  end loop;
  ont_ontologia.recalcular_fecho;
  commit;
  dbms_output.put_line('HABILIDADE: ' || n_novo || ' conceitos novos, ' || n_term || ' já existiam');
end;
/
""")
    L.append("""prompt
prompt === Confira a ordem da INSTRUÇÃO (vazio = corrigir à mão) ===
select cod, ordem, nome from ont_instrucao_ordem order by ordem nulls first, cod;
prompt === Confira a ordem dos NÍVEIS de conhecimento ===
select codigo, ordem, descricao from ont_nivel_ordem order by ordem nulls first, codigo;
select tipo, count(*) conceitos from ont_conceito group by tipo order by tipo;
prompt 07_carga: carga inicial feita.
""")
    sql = '\n'.join(L)
    # a função exists_termo_exato é local ao bloco: declarada como função PL/SQL embutida
    sql = sql.replace("""declare
  v_id   number;
  v_norm varchar2(1000);
  n_novo number := 0;
  n_term number := 0;""", """declare
  v_id   number;
  v_norm varchar2(1000);
  n_novo number := 0;
  n_term number := 0;
  function exists_termo_exato (p_conceito number, p_norm varchar2) return number is
    r number;
  begin
    select count(*) into r from ont_termo where conceito_id = p_conceito and texto_norm = p_norm;
    return case when r > 0 then 1 else 0 end;
  end;""")
    open(os.path.join(AQUI, '07_carga.sql'), 'w', encoding='ascii').write(ascii_seguro(sql))
    print('07_carga.sql: %d conceitos, %d termos, %d relações' % (len(CONCEITOS), n_termos, len(RELACOES)))


if __name__ == '__main__':
    gerar()
    gerar_testes()
