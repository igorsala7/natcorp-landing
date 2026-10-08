/* +========================================================================================+
   |  ONTOLOGIA DE RECRUTAMENTO - 99  REMOVER TUDO                                            |
   +========================================================================================+
   Apaga TODOS os objetos ONT_* (tabelas, visoes, pacotes, tipos e a rotina). Nenhuma tabela da
   base e tocada. ATENCAO: a curadoria feita (conceitos, termos, relacoes) se perde - exporte
   ONT_CONCEITO, ONT_TERMO e ONT_RELACAO antes, se quiser guardar.
*/
set define off
begin dbms_scheduler.drop_job('ONT_ROTINA_NOTURNA', force => true); exception when others then null; end;
/
begin
  for o in (select object_name, object_type from user_objects
             where object_name like 'ONT\_%' escape '\'
               and object_type in ('PACKAGE', 'VIEW', 'TABLE', 'TYPE')
             order by decode(object_type, 'PACKAGE', 1, 'VIEW', 2, 'TABLE', 3, 'TYPE', 4),
                      decode(object_name, 'ONT_TOKEN_TAB', 1, 'ONT_LINHA_TAB', 1, 2)) loop
    execute immediate 'drop ' || lower(o.object_type) || ' ' || o.object_name
                      || case o.object_type when 'TABLE' then ' cascade constraints purge' when 'TYPE' then ' force' end;
  end loop;
end;
/
prompt 99_remover: objetos ONT_* removidos.
