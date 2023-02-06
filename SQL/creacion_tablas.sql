ALTER SESSION SET "_oracle_script" = TRUE;

CREATE USER Nucleus_Project IDENTIFIED BY 2802;

GRANT DBA TO Nucleus_Project;

drop table pertenecebib;
drop table vincula;
drop table ejecuta;
drop table compra;
drop table usuario;
drop table biblioteca;

/*==============================================================*/
/* Table: BIBLIOTECA                                            */
/*==============================================================*/
CREATE TABLE biblioteca (
    bib_id NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    CONSTRAINT pk_biblioteca PRIMARY KEY ( bib_id )
);

/*==============================================================*/
/* Table: CATEGORIA                                             */
/*==============================================================*/

CREATE TABLE categoria (
    cat_id       NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    cat_nombre   VARCHAR(50) NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY ( cat_id )
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/

CREATE TABLE usuario (
    usu_id               NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    bib_id               NUMBER NOT NULL,
    usu_nombre           VARCHAR(50) NOT NULL,
    usu_apellido         VARCHAR(50) NOT NULL,
    usu_email            VARCHAR(50) NOT NULL,
    usu_telefono         VARCHAR(15) NOT NULL,
    usu_nombre_usuario   VARCHAR(20) NOT NULL,
    usu_password         VARCHAR(20) NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY ( usu_id ),
    CONSTRAINT fk_biblioteca FOREIGN KEY ( bib_id ) REFERENCES biblioteca ( bib_id )
);

/*==============================================================*/
/* Table: EMPRESAEXTERIOR                                       */
/*==============================================================*/

CREATE TABLE empresaexterior (
    emp_id       NUMBER NOT NULL,
    emp_nombre   VARCHAR2(30) NOT NULL,
    EMP_LOGO BFILE,
    CONSTRAINT pk_empresaexterior PRIMARY KEY ( emp_id )
);

/*==============================================================*/
/* Table: VIDEOJUEGO                                            */
/*==============================================================*/

CREATE TABLE videojuego (
    vid_id       NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    vid_nombre   VARCHAR2(50) NOT NULL,
    emp_id       NUMBER NOT NULL,
    vid_estado   VARCHAR(20) NOT NULL,
    VID_PORTADA BFILE,
    CONSTRAINT pk_videojuego PRIMARY KEY ( vid_id ),
    CONSTRAINT fk_empresa FOREIGN KEY ( emp_id ) REFERENCES empresaexterior ( emp_id )
);

/*==============================================================*/
/* Table: "KEY"                                                 */
/*==============================================================*/

CREATE TABLE "KEY" (
    key_id               NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    vid_id               NUMBER NOT  NULL,
    key_precio           NUMBER NOT NULL,
    key_disponibilidad   VARCHAR(20) NOT NULL,
    CONSTRAINT pk_key PRIMARY KEY ( key_id ),
    CONSTRAINT fk_videojuego FOREIGN KEY ( vid_id ) REFERENCES videojuego ( vid_id )
);

/*==============================================================*/
/* Table: COMPRA                                                */
/*==============================================================*/

CREATE TABLE compra (
    com_id      NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    key_id      NUMBER NOT NULL,
    usu_id      NUMBER NOT NULL,
    com_fecha   DATE NOT NULL,
    CONSTRAINT pk_compra PRIMARY KEY ( com_id ),
    CONSTRAINT fk_usuario FOREIGN KEY ( usu_id ) REFERENCES usuario ( usu_id ),
    CONSTRAINT fk_key FOREIGN KEY ( key_id ) REFERENCES "KEY" ( key_id )
);

/*==============================================================*/
/* Table: EJECUTA                                               */
/*==============================================================*/

CREATE TABLE ejecuta (
    eje_id            NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    usu_id            NUMBER NOT NULL,
    vid_id            NUMBER NOT NULL,
    eje_fechainicio   DATE NOT NULL,
    eje_fechafin      DATE NOT NULL,
    CONSTRAINT pk_ejecuta PRIMARY KEY ( eje_id ),
    CONSTRAINT fk_videojuego1 FOREIGN KEY ( vid_id ) REFERENCES videojuego ( vid_id ),
    CONSTRAINT fk_usuario1 FOREIGN KEY ( usu_id ) REFERENCES usuario ( usu_id )
);

/*==============================================================*/
/* Table: CUENTAEXTERNA                                         */
/*==============================================================*/

CREATE TABLE cuentaexterna (
    cue_id         NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    emp_id         NUMBER NOT NULL,
    cue_email      VARCHAR(50) NOT NULL,
    cue_password   VARCHAR(50) NOT NULL,
    CONSTRAINT pk_cuentaexterna PRIMARY KEY ( cue_id ),
    CONSTRAINT fk_empresa1 FOREIGN KEY ( emp_id ) REFERENCES empresaexterior ( emp_id )
);

/*==============================================================*/
/* Table: PERTENECEBIB                                          */
/*==============================================================*/

CREATE TABLE pertenecebib (
    bib_id   NUMBER NOT NULL,
    vid_id   NUMBER NOT NULL,
    CONSTRAINT pk_pertenecebib PRIMARY KEY ( bib_id,vid_id ),
    CONSTRAINT fk_videojuego2 FOREIGN KEY ( vid_id ) REFERENCES videojuego ( vid_id ),
    CONSTRAINT fk_biblioteca1 FOREIGN KEY ( bib_id ) REFERENCES biblioteca ( bib_id )
);

/*==============================================================*/
/* Table: PERTENECECAT                                          */
/*==============================================================*/

CREATE TABLE pertenececat (
    vid_id   NUMBER NOT NULL,
    cat_id   NUMBER NOT NULL,
    CONSTRAINT pk_pertenececat PRIMARY KEY ( vid_id,cat_id ),
    CONSTRAINT fk_videojuego3 FOREIGN KEY ( vid_id ) REFERENCES videojuego ( vid_id ),
    CONSTRAINT fk_categoria FOREIGN KEY ( cat_id ) REFERENCES categoria ( cat_id )
);

/*==============================================================*/
/* Table: VINCULA                                               */
/*==============================================================*/

CREATE TABLE vincula (
    usu_id   NUMBER NOT NULL,
    cue_id   NUMBER NOT NULL,
    CONSTRAINT pk_vincula PRIMARY KEY ( usu_id,cue_id ),
    CONSTRAINT fk_usuario2 FOREIGN KEY ( usu_id ) REFERENCES usuario ( usu_id ),
    CONSTRAINT fk_cuentaexterna FOREIGN KEY ( cue_id ) REFERENCES cuentaexterna ( cue_id )
);