/*==============================================================*/
/* Table: BIBLIOTECA                                            */
/*==============================================================*/
CREATE TABLE biblioteca (
    bib_id NUMBER NOT NULL,
    CONSTRAINT pk_biblioteca PRIMARY KEY ( bib_id )
);

/*==============================================================*/
/* Table: CATEGORIA                                             */
/*==============================================================*/

CREATE TABLE categoria (
    cat_id       NUMBER NOT NULL,
    cat_nombre   VARCHAR(50) NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY ( cat_id )
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/

CREATE TABLE usuario (
    usu_id               NUMBER NOT NULL,
    bib_id               NUMBER NOT NULL,
    usu_nombre           VARCHAR(50) NOT NULL,
    usu_apellido         VARCHAR(50) NOT NULL,
    usu_email            VARCHAR(50) NOT NULL,
    usu_telefono         VARCHAR(15) NOT NULL,
    usu_nombre_usuario   VARCHAR(20) NOT NULL,
    usu_password         VARCHAR(20) NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY ( usu_id ),
    CONSTRAINT fk_biblioteca FOREIGN KEY ( bib_id )
        REFERENCES biblioteca ( bib_id )
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
    vid_id       NUMBER NOT NULL,
    vid_nombre VARCHAR2(50) NOT NULL,
    emp_id       NUMBER NOT NULL,
    vid_estado   VARCHAR(20) NOT NULL,
    VID_PORTADA BFILE,
    CONSTRAINT pk_videojuego PRIMARY KEY ( vid_id ),
    CONSTRAINT fk_empresa FOREIGN KEY ( emp_id )
        REFERENCES empresaexterior ( emp_id )
);

/*==============================================================*/
/* Table: "KEY"                                                 */
/*==============================================================*/

CREATE TABLE "KEY" (
    key_id               NUMBER NOT NULL,
    vid_id               NUMBER NOT  NULL,
    key_precio           NUMBER NOT NULL,
    key_disponibilidad   VARCHAR(20) NOT NULL,
    CONSTRAINT pk_key PRIMARY KEY ( key_id ),
    CONSTRAINT fk_videojuego FOREIGN KEY ( vid_id )
        REFERENCES videojuego ( vid_id )
);

/*==============================================================*/
/* Table: COMPRA                                                */
/*==============================================================*/

CREATE TABLE compra (
    com_id      NUMBER NOT NULL,
    key_id      NUMBER NOT NULL,
    usu_id      NUMBER NOT NULL,
    com_fecha   DATE NOT NULL,
    CONSTRAINT pk_compra PRIMARY KEY ( com_id ),
    CONSTRAINT fk_usuario FOREIGN KEY ( usu_id )
        REFERENCES usuario ( usu_id ),
    CONSTRAINT fk_key FOREIGN KEY ( key_id )
        REFERENCES "KEY" ( key_id )
);

/*==============================================================*/
/* Table: EJECUTA                                               */
/*==============================================================*/

CREATE TABLE ejecuta (
    eje_id            NUMBER NOT NULL,
    usu_id            NUMBER NOT NULL,
    vid_id            NUMBER NOT NULL,
    eje_fechainicio   DATE NOT NULL,
    eje_fechafin      DATE NOT NULL,
    CONSTRAINT pk_ejecuta PRIMARY KEY ( eje_id ),
    CONSTRAINT fk_videojuego1 FOREIGN KEY ( vid_id )
        REFERENCES videojuego ( vid_id ),
    CONSTRAINT fk_usuario1 FOREIGN KEY ( usu_id )
        REFERENCES usuario ( usu_id )
);

/*==============================================================*/
/* Table: CUENTAEXTERNA                                         */
/*==============================================================*/

CREATE TABLE cuentaexterna (
    cue_id         NUMBER NOT NULL,
    emp_id         NUMBER NOT NULL,
    cue_email      VARCHAR(50) NOT NULL,
    cue_password   VARCHAR(50) NOT NULL,
    CONSTRAINT pk_cuentaexterna PRIMARY KEY ( cue_id ),
    CONSTRAINT fk_empresa1 FOREIGN KEY ( emp_id )
        REFERENCES empresaexterior ( emp_id )
);

/*==============================================================*/
/* Table: PERTENECEBIB                                          */
/*==============================================================*/

CREATE TABLE pertenecebib (
    bib_id   NUMBER NOT NULL,
    vid_id   NUMBER NOT NULL,
    CONSTRAINT pk_pertenecebib PRIMARY KEY ( bib_id,
                                             vid_id ),
    CONSTRAINT fk_videojuego2 FOREIGN KEY ( vid_id )
        REFERENCES videojuego ( vid_id ),
    CONSTRAINT fk_biblioteca1 FOREIGN KEY ( bib_id )
        REFERENCES biblioteca ( bib_id )
);

/*==============================================================*/
/* Table: PERTENECECAT                                          */
/*==============================================================*/

CREATE TABLE pertenececat (
    vid_id   NUMBER NOT NULL,
    cat_id   NUMBER NOT NULL,
    CONSTRAINT pk_pertenececat PRIMARY KEY ( vid_id,
                                             cat_id ),
    CONSTRAINT fk_videojuego3 FOREIGN KEY ( vid_id )
        REFERENCES videojuego ( vid_id ),
    CONSTRAINT fk_categoria FOREIGN KEY ( cat_id )
        REFERENCES categoria ( cat_id )
);

/*==============================================================*/
/* Table: VINCULA                                               */
/*==============================================================*/

CREATE TABLE vincula (
    usu_id   NUMBER NOT NULL,
    cue_id   NUMBER NOT NULL,
    CONSTRAINT pk_vincula PRIMARY KEY ( usu_id,
                                        cue_id ),
    CONSTRAINT fk_usuario2 FOREIGN KEY ( usu_id )
        REFERENCES usuario ( usu_id ),
    CONSTRAINT fk_cuentaexterna FOREIGN KEY ( cue_id )
        REFERENCES cuentaexterna ( cue_id )
);

/*==============================================================*/
/* INSERCION DE DATOS                                          */
/*==============================================================*/

INSERT INTO EMPRESAEXTERIOR (EMP_ID, EMP_NOMBRE, EMP_LOGO) VALUES ('1', 'Steam', BFILENAME('DIR_PORTADAS_EMPRESAS', 'steam.png'));
INSERT INTO EMPRESAEXTERIOR (EMP_ID, EMP_NOMBRE, EMP_LOGO) VALUES ('2', 'Origin',  BFILENAME('DIR_PORTADAS_EMPRESAS', 'origin.png'));
INSERT INTO EMPRESAEXTERIOR (EMP_ID, EMP_NOMBRE, EMP_LOGO) VALUES ('3', 'uPlay',  BFILENAME('DIR_PORTADAS_EMPRESAS', 'uplay.webp'));
INSERT INTO EMPRESAEXTERIOR (EMP_ID, EMP_NOMBRE, EMP_LOGO) VALUES ('4', 'Epic Games Store',  BFILENAME('DIR_PORTADAS_EMPRESAS', 'epic_games.png'));
INSERT INTO EMPRESAEXTERIOR (EMP_ID, EMP_NOMBRE) VALUES ('5', 'GOG');
INSERT INTO EMPRESAEXTERIOR (EMP_ID, EMP_NOMBRE) VALUES ('6', 'Blizzard');

INSERT INTO CATEGORIA (CAT_ID, CAT_NOMBRE) VALUES ('1', 'Accion');
INSERT INTO CATEGORIA (CAT_ID, CAT_NOMBRE) VALUES ('2', 'Arcade');
INSERT INTO CATEGORIA (CAT_ID, CAT_NOMBRE) VALUES ('3', 'Deportivo');
INSERT INTO CATEGORIA (CAT_ID, CAT_NOMBRE) VALUES ('4', 'Estrategia');
INSERT INTO CATEGORIA (CAT_ID, CAT_NOMBRE) VALUES ('5', 'Simulacion');
INSERT INTO CATEGORIA (CAT_ID, CAT_NOMBRE) VALUES ('6', 'Juegos de mesa');
INSERT INTO CATEGORIA (CAT_ID, CAT_NOMBRE) VALUES ('7', 'Juegos musicales');

INSERT INTO BIBLIOTECA VALUES(1);
INSERT INTO BIBLIOTECA VALUES(2);
INSERT INTO BIBLIOTECA VALUES(3);
INSERT INTO BIBLIOTECA VALUES(4);

INSERT INTO USUARIO (USU_ID, BIB_ID, USU_NOMBRE, USU_APELLIDO, USU_EMAIL, USU_TELEFONO, USU_NOMBRE_USUARIO, USU_PASSWORD) VALUES ('1', '1', 'Naren ', 'Imbachi', 'naren@gmail.com', '3126789021', 'naren21', 'atlas123');
INSERT INTO USUARIO (USU_ID, BIB_ID, USU_NOMBRE, USU_APELLIDO, USU_EMAIL, USU_TELEFONO, USU_NOMBRE_USUARIO, USU_PASSWORD) VALUES ('2', '2', 'Ruben', 'Cruz', 'ruben@gmail.com', '3145678181', 'rscruz', 'software123');
INSERT INTO USUARIO (USU_ID, BIB_ID, USU_NOMBRE, USU_APELLIDO, USU_EMAIL, USU_TELEFONO, USU_NOMBRE_USUARIO, USU_PASSWORD) VALUES ('3', '3', 'Julian', 'Carvajal', 'julian@gmail.com', '3145261728', 'jcarvajal', 'galleta123');
INSERT INTO USUARIO (USU_ID, BIB_ID, USU_NOMBRE, USU_APELLIDO, USU_EMAIL, USU_TELEFONO, USU_NOMBRE_USUARIO, USU_PASSWORD) VALUES ('4', '4', 'Joan', 'Tuquerrez', 'joan@gmail.com', '3156782341', 'jtuquerrez', 'joan123');


INSERT INTO CUENTAEXTERNA (CUE_ID, EMP_ID, CUE_EMAIL, CUE_PASSWORD) VALUES ('1', '1', 'julian@gmail.com', '123galleta');
INSERT INTO CUENTAEXTERNA (CUE_ID, EMP_ID, CUE_EMAIL, CUE_PASSWORD) VALUES ('2', '2', 'julian@gmail.com', '456galleta');
INSERT INTO CUENTAEXTERNA (CUE_ID, EMP_ID, CUE_EMAIL, CUE_PASSWORD) VALUES ('3', '3', 'julian@gmail.com', '789galleta');
INSERT INTO CUENTAEXTERNA (CUE_ID, EMP_ID, CUE_EMAIL, CUE_PASSWORD) VALUES ('4', '1', 'ruben@gmail.com', '123max');
INSERT INTO CUENTAEXTERNA (CUE_ID, EMP_ID, CUE_EMAIL, CUE_PASSWORD) VALUES ('5', '2', 'naren@gmail.com', '123atlas');
INSERT INTO CUENTAEXTERNA (CUE_ID, EMP_ID, CUE_EMAIL, CUE_PASSWORD) VALUES ('6', '4', 'joan@gmail.com', '123joancito');

--Se crea el directorio (modificar la ruta)
CREATE DIRECTORY DIR_PORTADAS_STEAM AS 'C:\nucleus_images\steam';
CREATE DIRECTORY DIR_PORTADAS_UPLAY AS 'C:\nucleus_images\uPlay';
CREATE DIRECTORY DIR_PORTADAS_EPIC_GAMES AS 'C:\nucleus_images\epic_games';
CREATE DIRECTORY DIR_PORTADAS_ORIGIN AS 'C:\nucleus_images\origin';
CREATE DIRECTORY DIR_PORTADAS_EMPRESAS AS 'C:\nucleus_images\empresas_exteriores';

------------
INSERT INTO VIDEOJUEGO VALUES(1, 'MINECRAFT', 1, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_STEAM', 'minecraft.jpg'));
INSERT INTO VIDEOJUEGO VALUES(2, 'GOOSE GOOSE DUCK', 1, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_STEAM', 'goose_goose_duck.jpg'));
INSERT INTO VIDEOJUEGO VALUES(3, 'COUNTER_STRIKE: GLOBAL OFFENSIVE', 1, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_STEAM', 'counter_strike.jpg'));
INSERT INTO VIDEOJUEGO VALUES(4, 'DOTA 2', 1, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_STEAM', 'dota2.jpg'));
INSERT INTO VIDEOJUEGO VALUES(5, 'PUBG: BATTLEGROUNDS', 1, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_STEAM', 'pubg.jpg'));
INSERT INTO VIDEOJUEGO VALUES(6, 'APEX LEGENDS', 1, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_STEAM', 'apex.jpg'));
INSERT INTO VIDEOJUEGO VALUES(7, 'LOST ARK', 1, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_STEAM', 'lost_ark.jpg'));
INSERT INTO VIDEOJUEGO VALUES(8, 'GRAND THEFT AUTO V', 1, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_STEAM', 'grand_left_auto_v.jpg'));
INSERT INTO VIDEOJUEGO VALUES(9, 'RUST', 1, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_STEAM', 'rust.jpg'));
INSERT INTO VIDEOJUEGO VALUES(10, 'WALLPAPER ENGINE', 1, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_STEAM', 'wallpaper_engine.jpg'));


INSERT INTO VIDEOJUEGO VALUES(11, 'MASS EFFECT TRILOGY', 2, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_ORIGIN', 'mass_efect-jpg'));
INSERT INTO VIDEOJUEGO VALUES(12, 'BATTLEFIELD 4', 2, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_ORIGIN', 'battlefield4.jpg'));
INSERT INTO VIDEOJUEGO VALUES(13, 'BATTLEFIELD 5', 2, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_ORIGIN', 'battlefield5.jpg'));
INSERT INTO VIDEOJUEGO VALUES(14, 'THE SIMS 4', 2, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_ORIGIN', 'the_sims4.png'));
INSERT INTO VIDEOJUEGO VALUES(15, 'TITANFALL 2', 2, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_ORIGIN', 'titanfall2.jpg'));
INSERT INTO VIDEOJUEGO VALUES(16, 'NEED FOR SPEED HEAT', 2, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_ORIGIN', 'need_for_speed.jpg'));
INSERT INTO VIDEOJUEGO VALUES(17, 'UNRAVEL TWO', 2, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_ORIGIN', 'unravel_two.jpg'));
INSERT INTO VIDEOJUEGO VALUES(18, 'A WAY OUT', 2, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_ORIGIN', 'a way out.jpg'));



INSERT INTO VIDEOJUEGO VALUES(19, 'TOM CLANCYS RAINBOW SIX', 3, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_UPLAY', 'tom_clancys.jpg'));
INSERT INTO VIDEOJUEGO VALUES(20, 'FAR CRY 6', 3, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_UPLAY', 'far_cry_g.webp'));
INSERT INTO VIDEOJUEGO VALUES(21, 'ASSASIN�S CREED VALHALLA', 3, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_UPLAY', 'assasins_creed.jpg'));
INSERT INTO VIDEOJUEGO VALUES(22, 'RIDERS REPUBLIC', 3, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_UPLAY', 'riders_republic.jpg'));
INSERT INTO VIDEOJUEGO VALUES(23, 'ANNO 1800', 3, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_UPLAY', 'anno_1800}.jpg'));



INSERT INTO VIDEOJUEGO VALUES(24, 'GRAND THEFT AUTO V', 4, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_EPIC_GAMES', 'grand_theft_auto.jpg'));
INSERT INTO VIDEOJUEGO VALUES(25, 'VALORANT', 4, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_EPIC_GAMES', 'valorant.jpg'));
INSERT INTO VIDEOJUEGO VALUES(26, 'NARAKA: BLADEPOINT', 4, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_EPIC_GAMES', 'naraka.jpg'));
INSERT INTO VIDEOJUEGO VALUES(27, 'RED DEAD: REDEMPTION 2', 4, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_EPIC_GAMES', 'red_dead.webp'));
INSERT INTO VIDEOJUEGO VALUES(28, 'BLOONS', 4, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_EPIC_GAMES', 'bloons.jpg'));
INSERT INTO VIDEOJUEGO VALUES(29, 'AMOUNG US', 4, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_EPIC_GAMES', 'amoung_us.jpg'));
INSERT INTO VIDEOJUEGO VALUES(30, 'ADIOS', 4, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_EPIC_GAMES', 'adios.jpg'));
INSERT INTO VIDEOJUEGO VALUES(31, 'STAR WARS: BATTLEFORONT II:CELEBRATION EDITION', 4, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_EPIC_GAMES', 'starwars.webp'));
INSERT INTO VIDEOJUEGO VALUES(32, 'LEAGUE OF LEGENDS', 4, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_EPIC_GAMES', 'league_of_legends.jpg'));
INSERT INTO VIDEOJUEGO VALUES(33, 'FALL GUYS', 4, 'DISPONIBLE', BFILENAME('DIR_PORTADAS_EPIC_GAMES', 'fall_guys.jpg'));


INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('1', '1', '60000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('2', '1', '60000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('3', '1', '60000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('4', '1', '60000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('5', '1', '60000', 'Si')

INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('6', '2', '35000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('7', '2', '35000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('8', '2', '35000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('9', '2', '35000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('10', '2', '35000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('11', '3', '55000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('12', '3', '55000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('13', '3', '55000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('14', '3', '55000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('15', '3', '55000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('16', '4', '23000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('17', '4', '23000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('18', '4', '23000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('19', '4', '23000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('20', '4', '23000', 'Si')


INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('21', '5', '50000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('22', '5', '50000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('23', '5', '50000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('24', '5', '50000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('25', '5', '50000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('26', '5', '50000', 'Si')


INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('27', '6', '13000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('28', '6', '13000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('29', '6', '13000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('30', '6', '13000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('31', '6', '13000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('32', '6', '13000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('33', '6', '13000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('34', '7', '35000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('35', '7', '35000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('36', '7', '35000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('37', '7', '35000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('38', '7', '35000', 'Si')
INSERT INTO "KEY" (KEY_ID, VID_ID, KEY_PRECIO, KEY_DISPONIBILIDAD) VALUES ('39', '7', '35000', 'Si')






