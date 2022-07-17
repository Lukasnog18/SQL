CREATE DATABASE ap1;
USE ap1;
SHOW tables;

DROP TABLE IF EXISTS votos;
DROP TABLE IF EXISTS candidatos;
DROP TABLE IF EXISTS localidades;
DROP TABLE IF EXISTS cargos;
DROP TABLE IF EXISTS partidos;


CREATE TABLE partidos(
        numero int PRIMARY KEY,
        sigla varchar(10)
);


CREATE TABLE cargos(
        id int PRIMARY KEY,
        descricao varchar(20)
);


CREATE TABLE localidades(
        id int PRIMARY KEY,
        nome varchar(20),
        numero_votantes int
);


CREATE TABLE candidatos(
        numero_cand int,
        localidade_id int,
        nome varchar(30),
        numero_partido int,
        cargo_id int,
        PRIMARY KEY (numero_cand, localidade_id),
        FOREIGN KEY (localidade_id) REFERENCES localidades(id),
        FOREIGN KEY (numero_partido) REFERENCES partidos(numero),
        FOREIGN KEY (cargo_id) REFERENCES cargos(id)
);


CREATE TABLE votos(
        numero_cand int,
        localidade_id int,
        turno int,
        numero_votos int,
        PRIMARY KEY (numero_cand, localidade_id),
        FOREIGN KEY (numero_cand, localidade_id) REFERENCES candidatos(numero_cand, localidade_id)
);


INSERT INTO cargos values 
(1, 'Presidente'),
(2, 'Governador'),
(3, 'Senador'),
(4, 'Dep. Federal'),
(5, 'Dep. Estadual');


INSERT INTO partidos values 
(13, 'PT'),
(45, 'PSDB'),
(40, 'PSB'),
(50, 'PSOL'),
(43, 'PV'),
(90, 'PROS'),
(15, 'PMDB');


INSERT INTO localidades values 
(1, 'Brasil',142822046),
(2, 'Ceará', 6268909),
(3, 'Piauí', 2344476);


INSERT INTO candidatos values 
(50, 1, 'Luciana', 50, 1),
(13, 1, 'Dilma', 13, 1),
(45, 1, 'Aécio', 45, 1),
(40, 1, 'Marina', 40, 1),
(15, 2, 'Eunício', 15, 2),
(13, 2, 'Camilo', 13, 2),
(40, 2, 'Eliane', 40, 2),
(50, 2, 'Ailton', 50, 2),
(900, 2, 'Mauro', 90, 3),
(456, 2, 'Tasso', 45, 3),
(400, 2, 'Geovana', 40, 3);


INSERT INTO votos values 
(50, 1, 1, 1612186),
(13, 1, 1, 43267668),
(45, 1, 1, 34897211),
(40, 1, 1, 22176619),
(15, 2, 1, 1979499),
(13, 2, 1, 2039233),
(40, 2, 1, 144507),
(50, 2, 1, 102394),
(900, 2, 1, 1573732),
(456, 2, 1, 2314796),
(400, 2, 1, 66895);