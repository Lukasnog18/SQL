-- a) Selecionar por partido o total de votos no primeiro turno para presidente
SELECT p.sigla,
(SELECT SUM(v.numero_votos)
FROM candidatos cand, votos v, cargos car
WHERE cand.numero_partido = p.numero AND
	  cand.numero_cand = v.numero_cand AND
      cand.localidade_id = v.localidade_id AND
      cand.cargo_id = car.id AND
      car.descricao = 'Presidente' AND
      v.turno = 1
) as votos
FROM partidos p
ORDER BY votos DESC;


-- b) Selecionar todos os candidatos que, no primeiro turno, receberam mais votos
-- que a média de votos da sua localidade (usar view)
DROP VIEW votos_primeiro_turno;

CREATE VIEW votos_primeiro_turno AS
SELECT cand.nome AS nome_cand, cand.numero_cand, car.descricao, p.sigla, v.numero_votos, l.nome AS nome_localidade
FROM candidatos cand, partidos p, cargos car, localidades l, votos v
WHERE cand.numero_partido = p.numero AND
	  cand.cargo_id = car.id AND
      cand.localidade_id = l.id AND
      cand.numero_cand = v.numero_cand AND
      cand.localidade_id = v.localidade_id AND
      v.turno = 1;
      
SELECT *
FROM votos_primeiro_turno v1
WHERE v1.numero_votos > (SELECT AVG(v2.numero_votos)
						 FROM votos_primeiro_turno v2
                         WHERE v2.nome_localidade = v1.nome_localidade AND
							   v2.descricao = v1.descricao
						)
ORDER BY v1.nome_cand;


-- c) Selecionar o total de votos por cargo em cada localidade
SELECT car.descricao,
(SELECT SUM(v.numero_votos)
FROM votos v, candidatos cand
WHERE cand.cargo_id = car.id AND
	  cand.numero_cand = v.numero_cand AND
	  cand.localidade_id = v.localidade_id AND
      cand.localidade_id = 1
) as localidade1,
(SELECT SUM(v.numero_votos)
FROM votos v, candidatos cand
WHERE cand.cargo_id = car.id AND
	  cand.numero_cand = v.numero_cand AND
	  cand.localidade_id = v.localidade_id AND
      cand.localidade_id = 2
) as localidade2
FROM cargos car;


-- d) Selecionar o nome dos candidatos da localidade 2 que receberam votos
SELECT cand.nome
FROM candidatos cand
WHERE EXISTS (SELECT *
			  FROM votos v
              WHERE cand.numero_cand = v.numero_cand AND
					cand.localidade_id = v.localidade_id AND
					cand.localidade_id = 2
			 );


-- e) Selecionar o candidato com o maior número de votos no primeiro turno
SELECT cand.nome, v.numero_votos
FROM candidatos cand, votos v
WHERE cand.numero_cand = v.numero_cand AND
	  cand.localidade_id = v.localidade_id AND
      v.turno = 1 AND
      v.numero_votos = (SELECT MAX(v2.numero_votos)
						FROM votos v2
      );
      

-- f) Selecionar a porcentagem de votos que cada candidato recebeu na sua localidade
SELECT cand.nome,
(SELECT SUM(v.numero_votos)
FROM votos v
WHERE cand.numero_cand = v.numero_cand AND
	  cand.localidade_id = v.localidade_id AND
      v.turno = 1
)/l.numero_votantes*100 as porcentagem_de_votos
FROM candidatos cand, localidades l
WHERE cand.localidade_id = l.id;


-- g) Selecionar os partidos que não possuem candidatos concorrendo à presidência
SELECT *
FROM partidos p
WHERE NOT EXISTS (SELECT *
				  FROM candidatos cand, cargos car
                  WHERE cand.numero_partido = p.numero AND
						cand.cargo_id = car.id AND
                        car.descricao = 'Presidente'
				 )
ORDER BY p.sigla;
