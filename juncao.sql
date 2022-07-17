--  Listar primeito nome, último nome e endereco de todos os funcionarios do departamento pesquisa

SELECT pnome, unome, endereco
FROM funcionario f, departamento d
WHERE f.dnr = d.dnumero AND
      d.dnome = 'Pesquisa';

SELECT pnome, unome, endereco
FROM (funcionario f JOIN departamento d 
     ON f.dnr=d.dnumero)
WHERE d.dnome = 'Pesquisa';

-- Achar a soma dos salários de todos os funcionários do departamento ‘Pesquisa’, bem como o salário máximo, o salário mínimo e a média dos salários nesse departamento.

SELECT avg(salario), min(salario), max(salario), sum(salario)
FROM funcionario f JOIN departamento d 
        ON d.dnumero = f.dnr
WHERE d.dnome='Pesquisa';

----------------
select pnome, dnome 
from funcionario, departamento 
     where dnr=dnumero;

select pnome, dnome 
from funcionario 
     inner join departamento 
     on dnr=dnumero;

select pnome, dnome 
from funcionario 
     left outer join departamento 
     on dnr=dnumero;

-- Obter os nomes dos funcionários e a quantidade de dependentes que cada um deles possui.

SELECT f.pnome, COUNT(d.fcpf)
FROM funcionario f LEFT OUTER JOIN dependente d ON f.cpf=d.fcpf
GROUP BY f.cpf, f.pnome;

SELECT f.pnome, (
    SELECT COUNT(*)
    FROM dependente d
    WHERE d.fcpf = f.cpf
)
FROM funcionario f;

-- Nome e sobrenome de TODOS funcionários e contagem de departamentos que eles são gerentes (usar left outer join ou right outer join)

SELECT f.pnome, f.unome, COUNT(d.cpf_gerente)
FROM departamento d RIGHT OUTER JOIN funcionario f ON d.cpf_gerente = f.cpf
GROUP BY f.cpf, f.pnome, f.unome; 


---------------

SELECT *
FROM funcionario f FULL OUTER JOIN departamento d ON f.dnr=d.dnumero;

-- Obter os nomes de todos os funcionários e os nomes dos projetos onde eles trabalham

SELECT f.pnome, p.projnome
FROM (funcionario f LEFT OUTER JOIN trabalha_em t ON f.cpf=t.fcpf) FULL OUTER JOIN projeto p ON p.projnumero = t.pnr;


INSERT INTO funcionario
VALUES ('Ze','E','Almeida','98765432187','1937-11-10','Rua do Horto, 35,São Paulo, SP','M', 55000, NULL, NULL);