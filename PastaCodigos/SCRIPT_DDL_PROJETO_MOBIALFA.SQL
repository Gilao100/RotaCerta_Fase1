-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2026-09-17 23:07:02 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE AVALIACAO CASCADE CONSTRAINTS 
;

DROP TABLE CIDADAO CASCADE CONSTRAINTS 
;

DROP TABLE INTINERARIO CASCADE CONSTRAINTS 
;

DROP TABLE LINHA CASCADE CONSTRAINTS 
;

DROP TABLE OCORRENCIA CASCADE CONSTRAINTS 
;

DROP TABLE PONTO_PARADA CASCADE CONSTRAINTS 
;

DROP TABLE POSICAO_VEICULO CASCADE CONSTRAINTS 
;

DROP TABLE "SLA-COMPENSACAO" CASCADE CONSTRAINTS 
;

DROP TABLE VEICULO CASCADE CONSTRAINTS 
;

DROP TABLE VIAGEM CASCADE CONSTRAINTS 
;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE AVALIACAO 
    ( 
     ID_AVALIACAO        CHAR (3)  NOT NULL , 
     NOTA                NUMBER (10)  NOT NULL , 
     COMENTARIO          VARCHAR2 (50) , 
     DATA                DATE  NOT NULL , 
     CIDADAO_CPF_CIDADAO NUMBER (11)  NOT NULL , 
     VIAGEM_ID_VIAGEM    NUMBER (7)  NOT NULL 
    ) 
;

CREATE TABLE CIDADAO 
    ( 
     CPF_CIDADAO   NUMBER (11)  NOT NULL , 
     NOME          VARCHAR2 (50)  NOT NULL , 
     EMAIL         VARCHAR2 (30)  NOT NULL , 
     TELEFONE      NUMBER  NOT NULL , 
     DATA_CADASTRO DATE 
    ) 
;

ALTER TABLE CIDADAO 
    ADD CONSTRAINT PK_CIDADAO PRIMARY KEY ( CPF_CIDADAO ) ;

CREATE TABLE INTINERARIO 
    ( 
     ID_INTINERARIO        VARCHAR2 (30)  NOT NULL , 
     VIAGEM_ID_VIAGEM      NUMBER (7)  NOT NULL , 
     PONTO_PARADA_ID_PONTO NUMBER (5)  NOT NULL , 
     ORIGEM_SEQUENCIA      VARCHAR2 (20)  NOT NULL , 
     SENTIDO               VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
                     NOT NULL 
    ) 
;

CREATE TABLE LINHA 
    ( 
     COD_LINHA    NUMBER (5)  NOT NULL , 
     NUMERO_LINHA NUMBER (7)  NOT NULL , 
     NOME_LINHA   VARCHAR2 (20)  NOT NULL , 
     MODAL        VARCHAR2 (20)  NOT NULL 
    ) 
;

ALTER TABLE LINHA 
    ADD CONSTRAINT PK_LINHA PRIMARY KEY ( COD_LINHA ) ;

CREATE TABLE OCORRENCIA 
    ( 
     ID_OCORRENCIA       NUMBER (10)  NOT NULL , 
     CIDADAO_CPF_CIDADAO NUMBER (11)  NOT NULL , 
     VIAGEM_ID_VIAGEM    NUMBER (7)  NOT NULL , 
     TIPO_OCORRENCIA     VARCHAR2 (20)  NOT NULL , 
     DATA_HORA           DATE  NOT NULL , 
     NIVEL_LOTACAO       VARCHAR2 (15) , 
     DESCRICAO           VARCHAR2 (50) 
    ) 
;

ALTER TABLE OCORRENCIA 
    ADD CONSTRAINT PK_OCORRENCIA PRIMARY KEY ( ID_OCORRENCIA ) ;

CREATE TABLE PONTO_PARADA 
    ( 
     ID_PONTO   NUMBER (5)  NOT NULL , 
     NOME_PONTO VARCHAR2 (20)  NOT NULL , 
     LATITUDE   BLOB  NOT NULL , 
     LONGITUDE  BLOB  NOT NULL , 
     REFERENCIA VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
                    
    ) 
;

ALTER TABLE PONTO_PARADA 
    ADD CONSTRAINT PK_PONTO_PARADA PRIMARY KEY ( ID_PONTO ) ;

CREATE TABLE POSICAO_VEICULO 
    ( 
     ID_POSICAO        BLOB  NOT NULL , 
     DATA_HORA         DATE  NOT NULL , 
     LATITUDE          BLOB  NOT NULL , 
     LONGITUDE         BLOB  NOT NULL , 
     VELOCIDADE        NUMBER (100) , 
     OCUPACAO_ESTIMADA VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
                    , 
     VIAGEM_ID_VIAGEM  NUMBER (7)  NOT NULL 
    ) 
;

CREATE TABLE "SLA-COMPENSACAO" 
    ( 
     ID_COMPENSACAO      NUMBER (10,2)  NOT NULL , 
     CIDADAO_CPF_CIDADAO NUMBER (11)  NOT NULL , 
     VIAGEM_ID_VIAGEM    NUMBER (7)  NOT NULL , 
     DESVIO_ETA_MIN      NUMBER (10)  NOT NULL , 
     VALOR_COMPENSACAO   NUMBER (10,2)  NOT NULL , 
     DATA_HORA           DATE  NOT NULL , 
     FATORES_CAUSAIS     VARCHAR2 (50) , 
     STATUS              VARCHAR2 (20)  NOT NULL 
    ) 
;

CREATE TABLE VEICULO 
    ( 
     ID_VEICULO       NUMBER (5)  NOT NULL , 
     VIAGEM_ID_VIAGEM NUMBER (7)  NOT NULL , 
     PLACA            VARCHAR2 (7)  NOT NULL , 
     CAPACIDADE       NUMBER (100)  NOT NULL , 
     MODAL            VARCHAR2 (20)  NOT NULL 
    ) 
;

ALTER TABLE VEICULO 
    ADD CONSTRAINT PK_VEICULO PRIMARY KEY ( ID_VEICULO ) ;

CREATE TABLE VIAGEM 
    ( 
     ID_VIAGEM           NUMBER (7)  NOT NULL , 
     DATA                DATE  NOT NULL , 
     HORA_PROG_PARTIDA   DATE  NOT NULL , 
     HORA_REAL_PARTIDA   TIMESTAMP (4) , 
     SENTIDO             VARCHAR2 (20)  NOT NULL , 
     STATUS_PONTUALIDADE VARCHAR2 (10)  NOT NULL , 
     LINHA_COD_LINHA     NUMBER (5)  NOT NULL 
    ) 
;

ALTER TABLE VIAGEM 
    ADD CONSTRAINT PK_VIAGEM PRIMARY KEY ( ID_VIAGEM ) ;

ALTER TABLE AVALIACAO 
    ADD CONSTRAINT FK_AVALIACAO_CIDADAO FOREIGN KEY 
    ( 
     CIDADAO_CPF_CIDADAO
    ) 
    REFERENCES CIDADAO 
    ( 
     CPF_CIDADAO
    ) 
;

ALTER TABLE AVALIACAO 
    ADD CONSTRAINT FK_AVALIACAO_VIAGEM FOREIGN KEY 
    ( 
     VIAGEM_ID_VIAGEM
    ) 
    REFERENCES VIAGEM 
    ( 
     ID_VIAGEM
    ) 
;

ALTER TABLE INTINERARIO 
    ADD CONSTRAINT FK_INTINERARIO_PONTO_PARADA FOREIGN KEY 
    ( 
     PONTO_PARADA_ID_PONTO
    ) 
    REFERENCES PONTO_PARADA 
    ( 
     ID_PONTO
    ) 
;

ALTER TABLE INTINERARIO 
    ADD CONSTRAINT FK_INTINERARIO_VIAGEM FOREIGN KEY 
    ( 
     VIAGEM_ID_VIAGEM
    ) 
    REFERENCES VIAGEM 
    ( 
     ID_VIAGEM
    ) 
;

ALTER TABLE OCORRENCIA 
    ADD CONSTRAINT FK_OCORRENCIA_CIDADAO FOREIGN KEY 
    ( 
     CIDADAO_CPF_CIDADAO
    ) 
    REFERENCES CIDADAO 
    ( 
     CPF_CIDADAO
    ) 
;

ALTER TABLE OCORRENCIA 
    ADD CONSTRAINT FK_OCORRENCIA_VIAGEM FOREIGN KEY 
    ( 
     VIAGEM_ID_VIAGEM
    ) 
    REFERENCES VIAGEM 
    ( 
     ID_VIAGEM
    ) 
;

ALTER TABLE POSICAO_VEICULO 
    ADD CONSTRAINT FK_POSICAO_VEICULO_VIAGEM FOREIGN KEY 
    ( 
     VIAGEM_ID_VIAGEM
    ) 
    REFERENCES VIAGEM 
    ( 
     ID_VIAGEM
    ) 
;

ALTER TABLE "SLA-COMPENSACAO" 
    ADD CONSTRAINT "FK_SLA-COMPENSACAO_CIDADAO" FOREIGN KEY 
    ( 
     CIDADAO_CPF_CIDADAO
    ) 
    REFERENCES CIDADAO 
    ( 
     CPF_CIDADAO
    ) 
;

ALTER TABLE "SLA-COMPENSACAO" 
    ADD CONSTRAINT "FK_SLA-COMPENSACAO_VIAGEM" FOREIGN KEY 
    ( 
     VIAGEM_ID_VIAGEM
    ) 
    REFERENCES VIAGEM 
    ( 
     ID_VIAGEM
    ) 
;

ALTER TABLE VEICULO 
    ADD CONSTRAINT FK_VEICULO_VIAGEM FOREIGN KEY 
    ( 
     VIAGEM_ID_VIAGEM
    ) 
    REFERENCES VIAGEM 
    ( 
     ID_VIAGEM
    ) 
;

ALTER TABLE VIAGEM 
    ADD CONSTRAINT FK_VIAGEM_LINHA FOREIGN KEY 
    ( 
     LINHA_COD_LINHA
    ) 
    REFERENCES LINHA 
    ( 
     COD_LINHA
    ) 
;



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             0
-- ALTER TABLE                             17
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   3
-- WARNINGS                                 0
