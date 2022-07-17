CREATE DATABASE db_empresa;
USE db_empresa;
SHOW databases;

SELECT * FROM funcionario;
SELECT * FROM departamento;
SELECT * FROM projeto;
SELECT * FROM trabalha_em;
SELECT * FROM dependente;
SELECT * FROM localizacao_dep;



SHOW TABLES;

begin;
DROP TABLE IF EXISTS funcionario CASCADE;
DROP TABlE IF EXISTS departamento CASCADE;
DROP TABlE IF EXISTS LOCALIZACAO_DEP CASCADE;
DROP TABlE IF EXISTS PROJETO CASCADE;
DROP TABlE IF EXISTS DEPENDENTE CASCADE;
DROP TABlE IF EXISTS TRABALHA_EM CASCADE;
create table FUNCIONARIO(
	Pnome VARCHAR(15) NOT NULL,
	Minicial CHAR (1),
	Unome VARCHAR (15) NOT NULL,
	Cpf CHAR(11) NOT NULL,
	Datanasc DATE NOT NULL,
	Endereco VARCHAR(40),
	Sexo CHAR(1),
	Salario decimal(10,2), 
	Cpf_supervisor CHAR(11),
	Dnr INT,
	PRIMARY KEY(Cpf),
	FOREIGN KEY(Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf));	
create table DEPARTAMENTO(
	Dnome VARCHAR(15) NOT NULL,
	Dnumero INT  NOT NULL,
	Cpf_gerente CHAR(11),
	Data_inicio_gerente DATE,
	PRIMARY KEY (Dnumero),
	UNIQUE(Dnome),
	FOREIGN KEY(Cpf_gerente) REFERENCES FUNCIONARIO(Cpf));		
create table LOCALIZACAO_DEP(
	Dnumero INT NOT NULL,
	Dlocal VARCHAR(15) NOT NULL,
	PRIMARY KEY (Dnumero, Dlocal),
	FOREIGN KEY (Dnumero) REFERENCES DEPARTAMENTO(Dnumero));
create table PROJETO(
	Projnome VARCHAR(15) NOT NULL,
	Projnumero INT NOT NULL,
	Projlocal VARCHAR(15),
	Dnum INT NOT NULL,
	PRIMARY KEY(ProjNumero),
	UNIQUE(Projnome),
	FOREIGN KEY (Dnum) REFERENCES DEPARTAMENTO(Dnumero));
create table DEPENDENTE(
	Fcpf CHAR(11) NOT NULL,
	Nome_dependente VARCHAR(15) NOT NULL,
	Sexo CHAR,
	Datanasc DATE,
	Parentesco VARCHAR(8),
	PRIMARY KEY(Fcpf, Nome_dependente),
	FOREIGN KEY(Fcpf) REFERENCES FUNCIONARIO(CPF));	
create table TRABALHA_EM(
	Fcpf CHAR (11) NOT NULL,
	Pnr INT  NOT NULL,
	Horas DECIMAL(3,1) NOT NULL,
	PRIMARY KEY (Fcpf,Pnr),
	FOREIGN KEY (Pnr) REFERENCES PROJETO (Projnumero),
	FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO (Cpf));
		
alter table FUNCIONARIO	ADD FOREIGN KEY(Dnr) REFERENCES DEPARTAMENTO(Dnumero);
 

insert into FUNCIONARIO values
	('Jorge','E','Brito','88866555576','1937-11-10','Rua do Horto, 35,São Paulo, SP','M', 55000, NULL, NULL),
	('Fernando','T','Wong','33344555587', '1955-12-08','Rua da lapa, 34, Sao Paulo, SP','M', 40000, '88866555576', NULL),
	('Jennifer','S','Souza','98765432168','1941-06-20','Av. Arthur de Lima, 54, Santo Andre, SP','F', 43000, '88866555576', NULL),
	('João','B','Silva','12345678966', '1965-01-09','Rua das flores, 751, São Paulo, SP','M', 30000, '33344555587', NULL),
	('Alice','J','Zelaya','99988777767', '1968-01-19','Rua Souza Lima, 35, Curitiba, PR','F', 25000, '98765432168', NULL),
	('Ronaldo','K','Lima','66688444476','1962-09-15','Rua Rebouças,65, Piracicaba, SP','M', 38000, '33344555587', NULL),
	('Joice','A','Leite','45345345376','1972-07-31','Av. Lucas Obes, 74,São Paulo, SP','F', 25000, '33344555587', NULL),
	('André','V','Pereira','98798798733','1969-03-29','Rua Timbira, 35,São Paulo, SP','M', 25000, '98765432168', NULL);

 insert into DEPARTAMENTO values(
	'Pesquisa',5, '33344555587', '1988-05-22'),
	('Administracao',4, '98765432168', '1995-01-01'),
	('Matriz',1, '88866555576', '1981-06-19');	
	
update Funcionario
	SET	Dnr = 1
	where Pnome= 'Jorge';
	Update Funcionario
	SET	Dnr = 5
	where Pnome= 'Fernando';
	Update Funcionario
	SET	Dnr = 4
	where Pnome= 'Jennifer';
	Update Funcionario
	SET	Dnr = 5
	where Pnome= 'João';
	Update Funcionario
	SET	Dnr = 4
	where Pnome= 'Alice';
	Update Funcionario
	SET	Dnr = 5
	where Pnome= 'Ronaldo';
	Update Funcionario
	SET	Dnr = 4
	where Pnome= 'Joice';
	Update Funcionario
	SET	Dnr = 4
	where Pnome= 'André';
    
	
insert into DEPENDENTE values(
	 '33344555587', 'Alicia','F', '1986-04-05', 'Filha'),
	('33344555587', 'Tiago','M', '1983-10-25', 'Filho'),
	('33344555587', 'Janaina','F', '1958-05-03', 'Esposa'),
	('98765432168', 'Antonio','M', '1942-02-28', 'Marido'),
	('12345678966', 'Michael','M', '1988-01-04', 'Filho'),
	('12345678966', 'Alice','F', '1988-12-30', 'Filha'),
	('12345678966', 'Elizabeth','F', '1967-05-05', 'Esposa');	
insert into LOCALIZACAO_DEP values(
	1, 'São Paulo'),
	(4, 'Mauá'),
	(5, 'Santo Andre'),
	(5, 'Itú'),
	(5, 'São Paulo');	
insert into PROJETO values(
	'ProdutoX',1, 'Santo Andre', 5),
	('ProdutoY',2, 'Itu', 5),
	('ProdutoZ',3, 'São Paulo', 5),
	('Informatizacao',10, 'Maua', 4),
	('Reorganizacao',20, 'Sao Paulo', 1),
	('NovosBeneficios',30, 'Maua', 4);
insert into TRABALHA_EM values(
	12345678966,1, 32.5),
	(12345678966,2, 7.5),
	(66688444476,3, 40.0),
	(45345345376,1, 20.0),
	(45345345376,2, 20.0),
	(33344555587,2, 10.0),
	(33344555587,3, 10.0),
	(33344555587,10, 10.0),
	(33344555587,20, 10.0),
	(99988777767,30, 30.0),
	(99988777767,10, 10.0),
	(98798798733,10, 35.0),
	(98798798733,30, 5.0),
	(98765432168,30, 20.0),
	(98765432168,20, 15.0),
	(88866555576,20, 10.0);
commit;