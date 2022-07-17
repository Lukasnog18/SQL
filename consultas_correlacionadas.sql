-- Listar todos os funcionários que tem dependente

SELECT pnome
FROM funcionario
WHERE EXISTS (
    SELECT *
    FROM dependente
    WHERE fcpf = cpf
);

SELECT pnome
FROM funcionario
WHERE cpf IN (
    SELECT fcpf
    FROM dependente
    WHERE fcpf = cpf
);

-- Listar nomes dos funcionários que não tem dependentes

SELECT pnome
FROM funcionario
WHERE NOT EXISTS (
    SELECT *
    FROM dependente
    WHERE fcpf = cpf
);

-- Listar nome dos gerentes que possuem pelo menos um dependente
SELECT f.pnome
FROM funcionario f
WHERE EXISTS (
    SELECT *
    FROM dependente d
    WHERE d.fcpf = f.cpf
) AND
EXISTS (
    SELECT *
    FROM departamento de
    WHERE de.cpf_gerente = f.cpf
);

SELECT pnome
FROM funcionario, departamento
WHERE cpf=cpf_gerente AND
    EXISTS (
        SELECT *
        FROM dependente
        WHERE fcpf = cpf
    );

-- Recuperar os nomes de todos os funcionários que têm dois ou mais dependentes. 

SELECT pnome
FROM funcionario f
WHERE (SELECT COUNT(*)
      FROM dependente d
      WHERE d.fcpf=f.cpf) >= 2;

-- Listar nome de departamentos com empregados ganhando 1.1 vezes mais que a média do departamento

SELECT d.dnome
FROM funcionario f1, departamento d
WHERE f1.dnr = d.dnumero AND
      f1.salario > 1.1*(
            SELECT avg(salario)
            FROM funcionario f
            WHERE f.dnr=f1.dnr);


SELECT dnome
FROM departamento d
WHERE EXISTS 
    (SELECT *
    FROM funcionario f1
    WHERE f1.dnr = d.dnumero AND
          f1.salario > 1.1*(
                SELECT avg(salario)
                FROM funcionario f
                WHERE f.dnr=d.dnumero));

