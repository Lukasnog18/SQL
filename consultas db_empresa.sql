-- Obter o nome dos funcionários que trabalham em departamentos que possuem a letra 's' no nome
SELECT f.pnome
FROM departamento d, funcionario f
WHERE LOWER(dnome) LIKE '%s%' AND
	  f.dnr = d.dnumero;


-- Liste os funcionários que tem o salário maior que a média salarial da empresa
SELECT *
FROM funcionario
WHERE salario > (
	  SELECT AVG(salario)
	  FROM funcionario
);


-- Liste todos os funcionários que trabalham em Mauá
SELECT *
FROM funcionario
WHERE cpf IN (
	  SELECT fcpf
	  FROM projeto, trabalha_em
	  WHERE projnumero = pnr AND
			projlocal = 'Maua'
);


-- Recuperar o nome de cada funcionario que tem dependente com mesmo nome e sexo
SELECT *
FROM funcionario f
WHERE f.cpf IN (
	  SELECT d.fcpf
	  FROM dependente d
	  WHERE d.nome_dependente = f.pnome AND
			d.sexo = f.sexo
);

INSERT INTO dependente
VALUES ('99988777767', 'Alice', 'F','1988-12-30','Filha');


-- Para cada departamento que tem mais de um funcionário, recuperar o número do departamento
-- e a quantidade de funcionários que estão ganhando mais que R$35.000,00
SELECT f.dnr, (
	   SELECT COUNT(*)
	   FROM funcionario f1
	   WHERE f1.dnr = f.dnr AND
			 f1.salario > 35000
)
FROM funcionario f
WHERE f.dnr IS NOT NULL
GROUP BY f.dnr
HAVING COUNT(*) > 1;
 
-- Usando IN:
SELECT f.dnr, COUNT(*)
FROM funcionario f
WHERE f.salario > 35000 AND
	  f.dnr IN (
				SELECT f1.dnr
                FROM funcionario f1
                WHERE f1.dnr IS NOT NULL
                GROUP BY f1.dnr
                HAVING COUNT(*) > 1
      
      )
GROUP BY f.dnr;



