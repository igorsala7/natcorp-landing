/* +========================================================================================+
   |  ONTOLOGIA DE RECRUTAMENTO - 08  ROTINA NOTURNA (DBMS_SCHEDULER)                         |
   +========================================================================================+
   Todo dia as 02:00: reclassifica os candidatos que mudaram desde a ultima rotina, refaz o fecho
   da ontologia e recalcula a aderencia de TODAS as vagas abertas (COD_SIT_REQ = 5 com processo
   seletivo). A PRIMEIRA execucao classifica o banco inteiro - rode-a a mao fora do horario
   (bloco no fim deste arquivo) e veja o tempo em ONT_LOG.
   Precisa do privilegio CREATE JOB (o 00_conferir.sql mostra).
*/
set define off

begin
  dbms_scheduler.drop_job('ONT_ROTINA_NOTURNA', force => true);
exception when others then null;   -- ainda nao existia
end;
/

begin
  dbms_scheduler.create_job(
    job_name        => 'ONT_ROTINA_NOTURNA',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'begin ont_aderencia.rotina_noturna; end;',
    start_date      => trunc(systimestamp) + interval '1' day + interval '2' hour,
    repeat_interval => 'FREQ=DAILY; BYHOUR=2; BYMINUTE=0; BYSECOND=0',
    enabled         => true,
    comments        => 'Ontologia de recrutamento: classifica candidatos e recalcula a aderencia das vagas abertas');
end;
/

prompt 08_rotina: ONT_ROTINA_NOTURNA agendada (todo dia as 02:00).
prompt Para a PRIMEIRA carga (banco inteiro), rode a mao:
prompt   exec ont_aderencia.rotina_noturna
prompt e acompanhe: select * from ont_log order by id desc;
