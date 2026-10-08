/* +========================================================================================+
   |  ONTOLOGIA DE RECRUTAMENTO - 02  ONT_TEXTO (normalizar e comparar texto)                 |
   +========================================================================================+
   As mesmas regras para TUDO (termos da ontologia, cadastro do candidato, requisicao):
     1. minusculas, sem acento, sem pontuacao ("NR-35" vira "nr35"; "C#" "csharp"; ".NET" "dotnet")
     2. tira as palavras fracas (ONT_PALAVRA_FRACA: de, da, em, para...)
     3. abreviacao que nao e comeco da palavra vira a palavra (ONT_ABREVIACAO: an -> analista)
     4. plural -> singular (negocios -> negocio, contabeis -> contabil, gestoes -> gestao)
   Duas palavras CASAM se forem iguais; ou se uma for o comeco da outra com 3+ letras (adm <->
   administracao) e a curta NAO for palavra conhecida (ONT_VOCAB: "excel" nao casa com "excelente");
   ou, com 6+ letras, se diferirem em UMA letra (adminstracao) e nao forem duas palavras conhecidas.
*/
set define off
alter session set nls_length_semantics = char;

create or replace type ont_token_t force as object (posicao number, token varchar2(60), p3 varchar2(3));
/
create or replace type ont_token_tab force as table of ont_token_t;
/
create or replace type ont_linha_tab force as table of varchar2(1000);
/

create or replace package ont_texto authid definer as
  /* minusculas sem acento (nao tira pontuacao) */
  function sem_acento (p_texto varchar2) return varchar2;
  /* texto -> palavras-raiz separadas por um espaco (o que e guardado em *_NORM) */
  function normalizar (p_texto varchar2) return varchar2;
  /* uma palavra (ja sem acento) -> raiz (singular) */
  function raiz (p_token varchar2) return varchar2;
  /* 1 se as duas palavras-raiz casam, 0 se nao */
  function casa (p_a varchar2, p_b varchar2) return number;
  /* 1 se a palavra esta em ONT_VOCAB */
  function conhecida (p_token varchar2) return number;
  /* 1 se o requisito (normalizado) aparece na linha (normalizada): ate 2 palavras, todas; 3+, 60% */
  function contem (p_linha_norm varchar2, p_req_norm varchar2) return number;
  /* palavras distintas de um texto normalizado, com posicao e as 3 primeiras letras */
  function tokens (p_norm varchar2) return ont_token_tab pipelined;
  /* quebra um texto livre em linhas (quebra de linha, ";" e "*") */
  function linhas (p_texto varchar2) return ont_linha_tab pipelined;
  /* rele ONT_PALAVRA_FRACA e ONT_ABREVIACAO (depois de mudar essas tabelas na mesma sessao) */
  procedure recarregar;
  /* texto -> data (dd/mm/aaaa, aaaa-mm-dd...), NULL se nao for data: para colunas de data guardadas como texto */
  function data_segura (p_texto varchar2) return date;
end ont_texto;
/

create or replace package body ont_texto as

  type t_set is table of varchar2(60) index by varchar2(60);
  g_fracas      t_set;
  g_abrev       t_set;
  g_vocab       t_set;
  g_carregado   boolean := false;

  c_com_acento  constant varchar2(100) := to_char(unistr('\00E1\00E0\00E2\00E3\00E4\00E9\00E8\00EA\00EB\00ED\00EC\00EE\00EF\00F3\00F2\00F4\00F5\00F6\00FA\00F9\00FB\00FC\00E7\00F1\00BA\00AA'));
  c_sem_acento  constant varchar2(100) := 'aaaaaeeeeiiiiooooouuuucnoa';

  procedure recarregar is
  begin
    g_fracas.delete; g_abrev.delete; g_vocab.delete;
    for r in (select token from ont_vocab) loop g_vocab(r.token) := 'S'; end loop;
    for r in (select palavra from ont_palavra_fraca) loop g_fracas(r.palavra) := 'S'; end loop;
    for r in (select token, expansao from ont_abreviacao) loop g_abrev(r.token) := r.expansao; end loop;
    g_carregado := true;
  end recarregar;

  procedure garantir is
  begin
    if not g_carregado then recarregar; end if;
  end garantir;

  function sem_acento (p_texto varchar2) return varchar2 is
  begin
    return translate(lower(p_texto), c_com_acento, c_sem_acento);
  end sem_acento;

  function raiz (p_token varchar2) return varchar2 is
    w varchar2(60) := p_token;
  begin
    if w is null or length(w) <= 3 then return w; end if;
    w := regexp_replace(w, 'coes$', 'cao');
    w := regexp_replace(w, 'oes$', 'ao');
    w := regexp_replace(w, 'aes$', 'ao');
    w := regexp_replace(w, 'eis$', 'il');
    w := regexp_replace(w, 'ais$', 'al');
    w := regexp_replace(w, '([rzl])es$', '\1');
    w := regexp_replace(w, '([^s])s$', '\1');
    return w;
  end raiz;

  function normalizar (p_texto varchar2) return varchar2 is
    t      varchar2(4000);
    w      varchar2(4000);
    saida  varchar2(4000);
    i      pls_integer := 1;
  begin
    if p_texto is null then return null; end if;
    garantir;
    t := sem_acento(substr(p_texto, 1, 3000));
    /* simbolos que carregam significado, antes de a pontuacao sumir */
    t := replace(t, 'pl/sql', ' plsql ');
    t := replace(t, 't-sql', ' tsql ');
    t := replace(t, 'c#', ' csharp ');
    t := replace(t, 'c++', ' cplusplus ');
    t := replace(t, '.net', ' dotnet ');
    t := regexp_replace(t, '(^|[^a-z])nr[ -]?([0-9]+)', '\1nr\2');           -- NR-35 -> nr35
    t := regexp_replace(t, '(^|[^a-z])pl[ -]sql', '\1plsql');
    t := regexp_replace(t, '(^|[^a-z])e[ -]social', '\1esocial');               -- e-Social -> esocial (o "e" sozinho cairia)
    t := regexp_replace(t, '(^|[^a-z])([a-z])\.([a-z])\.?([^a-z]|$)', '\1\2\3\4');  -- T.I. -> ti, R.H. -> rh
    t := regexp_replace(t, '[^a-z0-9]+', ' ');
    t := trim(t);
    loop
      w := regexp_substr(t, '[^ ]+', 1, i);
      exit when w is null;
      i := i + 1;
      w := substr(w, 1, 60);
      if length(w) >= 2 and not g_fracas.exists(w) then
        if g_abrev.exists(w) then w := g_abrev(w); end if;
        w := raiz(substr(w, 1, 60));
        if not g_fracas.exists(w) then
          saida := saida || case when saida is not null then ' ' end || w;
        end if;
      end if;
    end loop;
    return substr(saida, 1, 1000);
  end normalizar;

  function conhecida (p_token varchar2) return number is
  begin
    garantir;
    return case when p_token is not null and g_vocab.exists(p_token) then 1 else 0 end;
  end conhecida;

  function casa (p_a varchar2, p_b varchar2) return number is
    curta varchar2(60);
    longa varchar2(60);
  begin
    if p_a is null or p_b is null then return 0; end if;
    if p_a = p_b then return 1; end if;
    garantir;
    if length(p_a) < length(p_b) then curta := p_a; longa := p_b; else curta := p_b; longa := p_a; end if;
    if length(curta) >= 3 and substr(longa, 1, length(curta)) = curta and not g_vocab.exists(curta) then return 1; end if;
    if length(p_a) >= 6 and length(p_b) >= 6 and utl_match.edit_distance(p_a, p_b) <= 1
       and not (g_vocab.exists(p_a) and g_vocab.exists(p_b)) then return 1; end if;
    return 0;
  end casa;

  function contem (p_linha_norm varchar2, p_req_norm varchar2) return number is
    type t_lista is table of varchar2(60);
    req    t_lista := t_lista();
    lin    t_lista := t_lista();
    w      varchar2(4000);
    i      pls_integer;
    achou  pls_integer := 0;
  begin
    if p_linha_norm is null or p_req_norm is null then return 0; end if;
    i := 1;
    loop w := regexp_substr(p_req_norm, '[^ ]+', 1, i); exit when w is null; req.extend; req(req.count) := substr(w, 1, 60); i := i + 1; end loop;
    i := 1;
    loop w := regexp_substr(p_linha_norm, '[^ ]+', 1, i); exit when w is null; lin.extend; lin(lin.count) := substr(w, 1, 60); i := i + 1; end loop;
    if req.count = 0 then return 0; end if;
    for a in 1 .. req.count loop
      for b in 1 .. lin.count loop
        if casa(req(a), lin(b)) = 1 then achou := achou + 1; exit; end if;
      end loop;
    end loop;
    if req.count <= 2 then return case when achou = req.count then 1 else 0 end; end if;
    return case when achou / req.count >= 0.6 then 1 else 0 end;
  end contem;

  function tokens (p_norm varchar2) return ont_token_tab pipelined is
    type t_vistos is table of number index by varchar2(60);
    vistos t_vistos;
    w      varchar2(4000);
    i      pls_integer := 1;
    pos    pls_integer := 0;
  begin
    if p_norm is null then return; end if;
    loop
      w := regexp_substr(p_norm, '[^ ]+', 1, i);
      exit when w is null;
      i := i + 1;
      w := substr(w, 1, 60);
      if not vistos.exists(w) then
        vistos(w) := 1;
        pos := pos + 1;
        pipe row (ont_token_t(pos, w, substr(w, 1, 3)));
      end if;
    end loop;
    return;
  end tokens;

  function linhas (p_texto varchar2) return ont_linha_tab pipelined is
    t  varchar2(32767);
    l  varchar2(4000);
    i  pls_integer := 1;
  begin
    if p_texto is null then return; end if;
    t := replace(replace(replace(p_texto, chr(13), chr(10)), ';', chr(10)), to_char(unistr('\2022')), chr(10));
    loop
      l := regexp_substr(t, '[^' || chr(10) || ']+', 1, i);
      exit when l is null;
      i := i + 1;
      l := trim(l);
      if length(l) >= 3 then pipe row (substr(l, 1, 1000)); end if;
    end loop;
    return;
  end linhas;

  function data_segura (p_texto varchar2) return date is
    t varchar2(40) := trim(substr(p_texto, 1, 40));
  begin
    if t is null then return null; end if;
    if regexp_like(t, '^\d{1,2}/\d{1,2}/\d{4}') then return to_date(substr(t, 1, 10), 'dd/mm/yyyy'); end if;
    if regexp_like(t, '^\d{4}-\d{2}-\d{2}') then return to_date(substr(t, 1, 10), 'yyyy-mm-dd'); end if;
    if regexp_like(t, '^\d{8}$') then return to_date(t, 'yyyymmdd'); end if;
    return null;
  exception when others then return null;
  end data_segura;

end ont_texto;
/
show errors package ont_texto
show errors package body ont_texto

prompt 02_ont_texto: pacote ONT_TEXTO criado.
