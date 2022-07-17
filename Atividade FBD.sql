-- 1) Recuperar todos os funcionários cujo endereço esteja em ‘São Paulo, SP’.
SELECT *
FROM funcionario
WHERE LOWER(endereco) LIKE '%são Paulo, sp%';


-- 2) Recuperar nome do departamento, nome completo do funcionário e nome do projeto onde ele trabalha,
-- ordenado por departamento, e, dentro de cada departamento, ordenado alfabeticamente pelo sobrenome,
-- depois pelo nome.
SELECT d.dnome, f.pnome, f.minicial, f.unome, p.projnome
FROM departamento d, funcionario f, projeto p, trabalha_em t
WHERE d.dnumero = f.dnr AND
	  d.dnumero = p.dnum AND
	  t.pnr = p.projnumero AND
      t.fcpf = f.cpf
ORDER BY d.dnome, f.pnome ASC;


-- 3) Recupere os nomes de todos os funcionários no departamento 5 que trabalham mais de 10 horas por 
-- semana no projeto ‘ProdutoX’.
SELECT f.pnome, f.minicial, f.unome
FROM funcionario f
WHERE f.dnr = 5 AND
	  f.cpf IN (
			  SELECT t.fcpf
			  FROM projeto p, trabalha_em t
			  WHERE t.horas > 10 AND
					p.projnome = 'ProdutoX' AND
                    p.projnumero = t.pnr
			  );


-- 4) Liste os nomes de todos os funcionários que possuem um dependente com o primeiro nome igual ao
-- seu próprio.
SELECT f.pnome, f.minicial, f.unome 
FROM funcionario f
WHERE f.cpf IN (
	  SELECT d.fcpf
      FROM dependente d
      WHERE d.nome_dependente = f.pnome
	  );


-- 5) Ache os nomes de todos os funcionários que são supervisionados diretamente por ‘Fernando Wong’.
SELECT f.pnome, f.minicial, f.unome
FROM funcionario f
WHERE f.cpf_supervisor IN (
	  SELECT f1.cpf
      FROM funcionario f1
      WHERE f1.pnome = 'Fernando' AND
			f1.unome = 'Wong'
	  );


-- 6) Recuperar os nomes de todos os funcionários que não possuem supervisores.
SELECT f.pnome, f.minicial, f.unome
FROM funcionario f
WHERE f.cpf_supervisor IS NULL;


-- 7) Selecionar CPFs de todos os funcionários que trabalham na mesma combinação de projeto e horas
-- que o funcionário de CPF 12345678966 trabalha.
SELECT DISTINCT f.cpf
FROM funcionario f, projeto p, trabalha_em t
WHERE f.cpf = t.fcpf AND
	  t.pnr = p.projnumero AND
      t.horas IN (
      SELECT t1.horas
      FROM funcionario f1, trabalha_em t1
      WHERE f1.cpf = t1.fcpf AND
			t1.fcpf = '12345678966'
      );


-- 8) Exibir os nomes dos funcionários cujo salário é maior do que o salário de todos os funcionários
-- do departamento de número 5.
SELECT *
FROM funcionario
WHERE salario > (
	  SELECT AVG(salario)
	  FROM funcionario
	  WHERE dnr = 5
	  );


-- 9) Obter o nome de cada funcionário que tem um dependente com o mesmo sexo do funcionário.
SELECT f1.pnome
FROM funcionario f1
WHERE cpf IN (
	  SELECT f.cpf
	  FROM funcionario f, dependente d
	  WHERE cpf = fcpf AND
			f1.sexo = d.sexo
	  );


-- 10) Listar os nomes dos gerentes que possuem pelo menos um dependente.
SELECT DISTINCT f1.pnome, f1.minicial, f1.unome
FROM dependente d1, funcionario f1
WHERE d1.fcpf = f1.cpf AND
	  d1.fcpf IN (
	  SELECT f.cpf
	  FROM departamento d, funcionario f
	  WHERE f.cpf = d.cpf_gerente
	  );


-- 11) Listar os CPFs de todos os funcionários que trabalham nos projetos de números 1, 2 ou 3.
SELECT f.cpf
FROM funcionario f
WHERE dnr IN (
	  SELECT p.dnum
	  FROM projeto p, departamento d
	  WHERE p.dnum = d.dnumero AND
			p.projnumero IN (1, 2, 3)
	  );


-- 12) Selecionar CPFs de todos os funcionários que trabalham na mesma combinação de projeto e horas que o
-- funcionário de CPF 12345678966 trabalha.
SELECT DISTINCT f.cpf
FROM funcionario f, projeto p, trabalha_em t
WHERE f.cpf = t.fcpf AND
	  t.pnr = p.projnumero AND
      t.horas IN (
      SELECT t1.horas
      FROM funcionario f1, trabalha_em t1
      WHERE f1.cpf = t1.fcpf AND
			t1.fcpf = '12345678966'
      );


-- 13) Exibir os nomes dos funcionários cujo salário é maior do que o salário de todos os funcionários
-- do departamento de número 5.
SELECT pnome, minicial, unome
FROM funcionario
WHERE salario > (
	  SELECT MAX(salario)
	  FROM funcionario
	  WHERE dnr = 5
	  );


-- 14) Obter o nome de cada funcionário que tem um dependente com o mesmo sexo do funcionário.
SELECT f1.pnome
FROM funcionario f1
WHERE f1.cpf IN (
	  SELECT f.cpf
	  FROM funcionario f, dependente d
	  WHERE f.cpf = d.fcpf AND
			f1.sexo = d.sexo
	  );


-- 15) Listar os nomes dos gerentes que possuem pelo menos um dependente.
SELECT DISTINCT f1.pnome, f1.minicial, f1.unome
FROM dependente d1, funcionario f1
WHERE d1.fcpf = f1.cpf AND
	  d1.fcpf IN (
	  SELECT f.cpf
	  FROM departamento d, funcionario f
	  WHERE f.cpf = d.cpf_gerente
	  );


-- 16) Exibir a soma dos salários de todos os funcionários, o salário máximo, o salário mínimo e a média dos salários.
SELECT SUM(salario), MAX(salario), MIN(salario), AVG(salario)
FROM funcionario;


-- 17) Exibir a soma dos salários de todos os funcionários de cada departamento, bem como o salário máximo,
-- o salário mínimo e a média dos salários de cada um desses departamentos.
SELECT SUM(salario), MAX(salario), MIN(salario), AVG(salario), dnr
FROM funcionario
GROUP BY dnr;


-- 18) Recuperar o número total de funcionários da empresa.
SELECT COUNT(cpf)
FROM funcionario;


-- 19) Recuperar o número de funcionários de cada departamento.
SELECT dnr, COUNT(dnr)
FROM funcionario
GROUP BY dnr;


-- 20) Obter o número de valores distintos de salário.
SELECT COUNT(DISTINCT salario)
FROM funcionario;


-- 21) Exibir os nomes de todos os funcionários que possuem dois ou mais dependentes.
SELECT f.pnome
FROM funcionario f, dependente d
WHERE f.cpf = d.fcpf
GROUP BY f.pnome
HAVING COUNT(*) > 2;


-- 22) Exibir o número do departamento, o número de funcionários no departamento e o salário médio do departamento,
-- para cada departamento da empresa.
SELECT dnr, COUNT(cpf), AVG(salario)
FROM funcionario
GROUP BY dnr;


-- 23) Listar o número do projeto, o nome do projeto e o número de funcionários que trabalham nesse projeto,
-- para cada projeto. 
SELECT p.projnumero, p.projnome, COUNT(*)
FROM projeto p, funcionario f, trabalha_em t
WHERE f.cpf = t.fcpf AND
	  p.projnumero = t.pnr
GROUP BY p.projnumero, p.projnome;

