-- Obter os nomes dos funcionários que ganham mais que a média salarial da empresa.
SELECT pnome, salario
FROM funcionario
WHERE salario > (SELECT AVG(salario)
                 FROM funcionario);

--  Obter os nomes dos funcionários e a quantidade de dependentes que cada um deles possui.
SELECT f.pnome, f.cpf, (
        SELECT COUNT(*)
        FROM dependente d
        WHERE d.fcpf=f.cpf
    )
FROM funcionario f;

SELECT f.cpf, count(*)
FROM funcionario f, dependente d
WHERE f.cpf=d.fcpf
GROUP BY f.cpf;

-- Números de projetos cujo gerente é Silva ou tem o Silva como funcionário
(SELECT p.projnumero
FROM projeto p, departamento d, funcionario f
WHERE p.dnum=d.dnumero AND
      d.cpf_gerente=f.cpf AND
      f.unome='Silva')
UNION
(SELECT projnumero
FROM projeto p, trabalha_em t, funcionario f
WHERE p.projnumero=t.pnr AND
      t.fcpf=f.cpf AND
      f.unome='Silva');


SELECT p.projnumero
FROM projeto p
WHERE p.projnumero in (
        SELECT p.projnumero
        FROM projeto p, departamento d, funcionario f
        WHERE p.dnum=d.dnumero AND
             d.cpf_gerente=f.cpf AND 
             f.unome='Silva')
    OR p.projnumero in (
        SELECT t.pnr
        FROM trabalha_em t, funcionario f
        WHERE t.fcpf=f.cpf AND
              f.unome='Silva'
    );

--  Obter os nomes dos funcionários que trabalham em departamentos que possuem a letra ‘s’ no nome do departamento.

SELECT pnome
FROM funcionario
WHERE dnr IN (
      SELECT dnumero
      FROM departamento
      WHERE LOWER(dnome) LIKE '%s%'
);

SELECT pnome
FROM funcionario f, departamento d
WHERE f.dnr=d.dnumero AND
      LOWER(dnome) LIKE '%s%';

-- Listar todos os empregados que têm salário maior que a média salarial da empresa

SELECT *
FROM funcionario
WHERE salario > (
      SELECT AVG(salario)
      from funcionario
);

-- Listar os funcionarios que trabalham em Mauá (usar IN)

SELECT *
FROM funcionario
WHERE cpf IN (
      SELECT DISTINCT fcpf
      FROM trabalha_em, projeto
      WHERE pnr=projnumero AND
            projlocal='Maua'
);

-- Recuperar o nome de cada funcionário que tem com dependente com o mesmo nome e o mesmo sexo
SELECT *
FROM funcionario f
WHERE f.cpf IN (
      SELECT d.fcpf
      FROM dependente d
      WHERE d.nome_dependente = f.pnome 
            AND d.sexo = f.sexo
);

INSERT INTO dependente
VALUES ('99988777767', 'Alice', 'F','1988-12-30','Filha');

-- Para cada departamento que tem mais de um funcionário, recuperar o número do departamento e a quantidade de  funcionários que estão ganhando mais de R$ 35.000,00.

SELECT f.dnr, (
      SELECT COUNT(*)
      FROM funcionario f1
      WHERE f1.dnr=f.dnr AND
            f1.salario > 35000
)
FROM funcionario f
WHERE f.dnr IS NOT NULL
GROUP BY f.dnr
HAVING COUNT(*) > 1;


SELECT f1.dnr, COUNT(*)
FROM funcionario f1
WHERE f1.salario > 35000 AND
      f1.dnr IN (
            SELECT f.dnr
            FROM funcionario f
            WHERE f.dnr IS NOT NULL
            GROUP BY f.dnr
            HAVING count(*)>1
)
GROUP BY f1.dnr;

-- Todos os cpf que trabalham em algum projeto em Mauá

SELECT DISTINCT fcpf
FROM trabalha_em
WHERE pnr = ANY (
      SELECT projnumero
      FROM projeto
      WHERE projlocal = 'Maua'
);

SELECT DISTINCT fcpf
FROM trabalha_em
WHERE pnr = SOME (
      SELECT projnumero
      FROM projeto
      WHERE projlocal = 'Maua'
);

SELECT DISTINCT fcpf
FROM trabalha_em
WHERE pnr IN (
      SELECT projnumero
      FROM projeto
      WHERE projlocal = 'Maua'
);

-- Obter o menor salário
SELECT MIN(salario)
FROM funcionario;

-- Obter pnome e salário do funcionário com menor salário

SELECT pnome, salario
FROM funcionario
WHERE salario = (
      SELECT MIN(salario)
      FROM funcionario
);

SELECT pnome, salario
FROM funcionario
WHERE salario <= ALL (
      SELECT salario
      FROM funcionario
);

-- Consulta para retornar os nomes dos funcionários cujo salário é maior do que o salário de todos os funcionários no departamento 5.

SELECT pnome
FROM funcionario
WHERE salario > ALL (
      SELECT salario
      FROM funcionario
      WHERE dnr=5
);

SELECT pnome
FROM funcionario
WHERE salario > (
      SELECT max(salario)
      FROM funcionario
      WHERE dnr=5
);

-- Listar departamento (número) com maior média salarial

SELECT dnr
FROM funcionario
WHERE dnr IS NOT NULL
GROUP BY dnr
HAVING AVG(salario) >= ALL (
      SELECT AVG(salario)
      FROM funcionario
      WHERE dnr IS NOT NULL
      GROUP BY dnr
);
