/*==============================================================*/
/* Auto Increment of the id in Biblioteca                                           */
/*==============================================================*/

CREATE SEQUENCE bibid_sequence
START WITH 1
INCREMENT BY 1;

create or replace trigger tr_create_bib
before insert on biblioteca
for each row
BEGIN
    SELECT bibid_sequence.NEXTVAL INTO :new.bib_id
    FROM DUAL;
END;

/*==============================================================*/
/* Asign of library to new user                                            */
/*==============================================================*/

create or replace trigger tr_asignn_bibuser
before insert on usuario
for each row
declare
    v_ultid number;
begin
    select max(bib_id)
    into v_ultid
    from biblioteca;
    :new.bib_id := v_ultid;
end;