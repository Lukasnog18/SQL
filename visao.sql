CREATE OR REPLACE VIEW func_dep as (
    SELECT f.pnome || ' ' || f.minicial || ' ' || f.unome as nome_completo, d.dnome as dnome
    FROM funcionario f, departamento d
    WHERE f.dnr = d.dnumero
);

SELECT *
FROM func_dep;

DROP VIEW func_dep;

-- pnome,unome,projnome,horas
CREATE OR REPLACE VIEW trabalha_em1 as (
    SELECT f.pnome, f.unome, p.projnome, t.horas
    FROM funcionario f, trabalha_em t, projeto p
    WHERE f.cpf = t.fcpf AND
        p.projnumero = t.pnr
);

SELECT *
FROM trabalha_em1;