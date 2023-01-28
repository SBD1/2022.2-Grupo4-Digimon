create OR REPLACE PROCEDURE cria_equipamento(
	nome varchar(20), 
	descricao varchar(255),
	preco_de_venda integer DEFAULT 0, 
	defesa_extra integer DEFAULT 0,
	ataque_extra integer DEFAULT 0,
	vida_extra integer DEFAULT 0,
	velocidade_extra integer DEFAULT 0
	)
as $cria_equipamento$

DECLARE
    idItem UUID;
begin
		insert into item ("nome", "descricao", "preco_de_venda")
		values (nome, descricao, preco_de_venda) returning "id_item" into idItem;
		
		insert into equipamento ("defesa_extra", "ataque_extra", "vida_extra", "velocidade_extra", "id_item")
		values (defesa_extra,ataque_extra,vida_extra,velocidade_extra, idItem);
END;

$cria_equipamento$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE cria_alimento(
	nome varchar(20), 
	descricao varchar(255),
	preco_de_venda integer DEFAULT 0, 
	experiencia integer DEFAULT 0, 
	cura integer DEFAULT 0
	)
as $cria_alimento$

DECLARE
    idItem UUID;
begin
		insert into item ("nome", "descricao", "preco_de_venda")
		values (nome, descricao, preco_de_venda) returning "id_item" into idItem;
	
		
		insert into alimento ("experiencia", "cura", "id_item")
		values (experiencia, cura, idItem);
END;

$cria_alimento$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE cria_chave(
	nome varchar(20), 
	descricao varchar(255),
	tipo varchar(20),
	preco_de_venda integer DEFAULT 0
	)
as $cria_chave$

DECLARE
    idItem UUID;
BEGIN
	
	if (SELECT tipo = any(enum_range(null::tipos_item_chave)::varchar(20)[])) then 
			insert into item ("nome", "descricao", "preco_de_venda")
			values (nome, descricao, preco_de_venda) returning "id_item" into idItem;
		
			insert into chave ("tipo", "id_item")
			values (tipo::tipos_item_chave, idItem);
	else
		raise 'Tipo de chave não existe';

		
	end if;
END;

$cria_chave$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE apaga_equipamento(
	idItem text
	)
as $apaga_equipamento$

DECLARE
    equipamentosEncontrados integer;

begin	
	select count(*) into equipamentosEncontrados from equipamento where "id_item"::text = idItem;
	if equipamentosEncontrados = 0 then
		raise 'Equipamento não encontrado';
	else
		delete from equipamento where "id_item"::text = idItem;
		delete from item where "id_item"::text = idItem;
	end if;
END;

$apaga_equipamento$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE apaga_alimento(
	idItem text
	)
as $apaga_alimento$

DECLARE
    alimentosEncontrados integer;

begin	
	select count(*) into alimentosEncontrados from alimento where "id_item"::text = idItem;
	if alimentosEncontrados = 0 then
		raise 'Alimento não encontrado';
	else
		delete from alimento where "id_item"::text = idItem;
		delete from item where "id_item"::text = idItem;
	end if;
END;

$apaga_alimento$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE apaga_chave(
	idItem text
	)
as $apaga_chave$

DECLARE
    chavesEncontradas integer;

begin	
	select count(*) into chavesEncontradas from chave where "id_item"::text = idItem;
	if chavesEncontradas = 0 then
		raise 'Alimento não encontrado';
	else
		delete from chave where "id_item"::text = idItem;
		delete from item where "id_item"::text = idItem;
	end if;
END;

$apaga_chave$ LANGUAGE plpgsql;





create OR REPLACE PROCEDURE cria_anjo(
	defesa_extra integer DEFAULT 0
	)
as $cria_anjo$

DECLARE
    idCategoriaDigimon UUID;
begin
		insert into categoria_digimon DEFAULT VALUES returning "id_categoria_digimon" into idCategoriaDigimon;
		
		insert into anjo ("defesa_extra", "id_categoria_digimon")
		values (defesa_extra, idCategoriaDigimon);
END;

$cria_anjo$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE cria_fantasma(
	ataque_extra integer DEFAULT 0
	)
as $cria_fantasma$

DECLARE
    idCategoriaDigimon UUID;
begin
		insert into categoria_digimon DEFAULT VALUES returning "id_categoria_digimon" into idCategoriaDigimon;
		
		insert into fantasma ("ataque_extra", "id_categoria_digimon")
		values (ataque_extra, idCategoriaDigimon);
END;

$cria_fantasma$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE cria_monge(
	vida_extra integer DEFAULT 0
	)
as $cria_monge$

DECLARE
    idCategoriaDigimon UUID;
begin
		insert into categoria_digimon DEFAULT VALUES returning "id_categoria_digimon" into idCategoriaDigimon;
		
		insert into monge ("vida_extra", "id_categoria_digimon")
		values (vida_extra, idCategoriaDigimon);
END;

$cria_monge$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE cria_ciborg(
	velocidade_extra integer DEFAULT 0
	)
as $cria_ciborg$

DECLARE
    idCategoriaDigimon UUID;
begin
		insert into categoria_digimon DEFAULT VALUES returning "id_categoria_digimon" into idCategoriaDigimon;
		
		insert into ciborg ("velocidade_extra", "id_categoria_digimon")
		values (velocidade_extra, idCategoriaDigimon);
END;

$cria_ciborg$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE cria_dragao(
	defesa_extra integer DEFAULT 0,
  	ataque_extra integer DEFAULT 0,
  	vida_extra integer DEFAULT 0,
    velocidade_extra integer DEFAULT 0
	)
as $cria_dragao$

DECLARE
    idCategoriaDigimon UUID;
begin
		insert into categoria_digimon DEFAULT VALUES returning "id_categoria_digimon" into idCategoriaDigimon;
		
		insert into dragao ("velocidade_extra", "defesa_extra", "ataque_extra", "vida_extra","id_categoria_digimon")
		values (velocidade_extra, defesa_extra, ataque_extra, vida_extra, idCategoriaDigimon);
END;

$cria_dragao$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE apaga_dragao(
	idCategoriaDigimon text
	)
as $apaga_dragao$

DECLARE
    dragoesEncontrados integer;

begin	
	select count(*) into dragoesEncontrados from dragao where "id_categoria_digimon"::text = idCategoriaDigimon;
	if dragoesEncontrados = 0 then
		raise 'Dragão não encontrado';
	else
		delete from dragao where "id_categoria_digimon"::text = idCategoriaDigimon;
		delete from categoria_digimon where "id_categoria_digimon"::text = idCategoriaDigimon;
	end if;
END;

$apaga_dragao$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE apaga_ciborg(
	idCategoriaDigimon text
	)
as $apaga_ciborg$

DECLARE
    ciborgsEncontrados integer;

begin	
	select count(*) into ciborgsEncontrados from ciborg where "id_categoria_digimon"::text = idCategoriaDigimon;
	if ciborgsEncontrados = 0 then
		raise 'Ciborg não encontrado';
	else
		delete from ciborg where "id_categoria_digimon"::text = idCategoriaDigimon;
		delete from categoria_digimon where "id_categoria_digimon"::text = idCategoriaDigimon;
	end if;
END;

$apaga_ciborg$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE apaga_monge(
	idCategoriaDigimon text
	)
as $apaga_monge$

DECLARE
    mongesEncontrados integer;

begin	
	select count(*) into mongesEncontrados from monge where "id_categoria_digimon"::text = idCategoriaDigimon;
	if mongesEncontrados = 0 then
		raise 'Monge não encontrado';
	else
		delete from monge where "id_categoria_digimon"::text = idCategoriaDigimon;
		delete from categoria_digimon where "id_categoria_digimon"::text = idCategoriaDigimon;
	end if;
END;

$apaga_monge$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE apaga_fantasma(
	idCategoriaDigimon text
	)
as $apaga_fantasma$

DECLARE
    fantasmasEncontrados integer;

begin	
	select count(*) into fantasmasEncontrados from fantasma where "id_categoria_digimon"::text = idCategoriaDigimon;
	if fantasmasEncontrados = 0 then
		raise 'Fantasma não encontrado';
	else
		delete from fantasma where "id_categoria_digimon"::text = idCategoriaDigimon;
		delete from categoria_digimon where "id_categoria_digimon"::text = idCategoriaDigimon;
	end if;
END;

$apaga_fantasma$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE apaga_anjo(
	idCategoriaDigimon text
	)
as $apaga_anjo$

DECLARE
    anjosEncontrados integer;

begin	
	select count(*) into anjosEncontrados from anjo where "id_categoria_digimon"::text = idCategoriaDigimon;
	if anjosEncontrados = 0 then
		raise 'Anjo não encontrado';
	else
		delete from anjo where "id_categoria_digimon"::text = idCategoriaDigimon;
		delete from categoria_digimon where "id_categoria_digimon"::text = idCategoriaDigimon;
	end if;
END;

$apaga_anjo$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE cria_monstro(idBatalha UUID, nivel integer) AS $cria_monstro$
 DECLARE 
	vidaPorNivel integer;
	idDigimon UUID;

BEGIN
SELECT
	vida_por_nivel, id_digimon INTO vidaPorNivel, idDigimon
	FROM digimon ORDER BY random LIMIT 1;

INSERT INTO monstro (nivel, vida_atual, id_digimon, id_batalha)
VALUES (nivel, vidaPorNivel * nivel, idDigimon, idBatalha);

END;

$cria_monstro$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE cria_chefe(
	idBatalha UUID,
	nivel integer,
	defesa_extra_chefe integer DEFAULT 0,
	ataque_extra_chefe integer DEFAULT 0,
	vida_extra_chefe integer DEFAULT 0,
	velocidade_extra_chefe integer DEFAULT 0
) AS $cria_chefe$ DECLARE vidaPorNivel integer;

idDigimon UUID;

idMOnstro UUID;

BEGIN
	
SELECT vida_por_nivel, id_digimon INTO vidaPorNivel, idDigimon
	FROM digimon ORDER BY random() LIMIT 1;

INSERT INTO
	monstro (nivel, vida_atual, id_digimon, id_batalha)
VALUES
	(
		nivel,
		vidaPorNivel * nivel + vida_extra_chefe,
		idDigimon,
		idBatalha
	) returning id_monstro INTO idMonstro;

INSERT INTO
	chefe (
		id_monstro,
		defesa_extra,
		ataque_extra,
		vida_extra,
		velocidade_extra
	)
VALUES
	(
		idMonstro,
		defesa_extra_chefe,
		ataque_extra_chefe,
		vida_extra_chefe,
		velocidade_extra_chefe
	);

END;

$cria_chefe$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE cria_batalha(
	idInstanciaDigimon text,
	defesa_extra_chefe integer DEFAULT 0,
	ataque_extra_chefe integer DEFAULT 0,
	vida_extra_chefe integer DEFAULT 0,
	velocidade_extra_chefe integer DEFAULT 0
) AS $cria_batalha$ 

DECLARE idBatalha UUID;

	nivelInstanciaDigimon integer;

BEGIN
	
SELECT nivel INTO nivelInstanciaDigimon
FROM instancia_digimon WHERE id_instancia_digimon::text = idInstanciaDigimon;

IF nivelInstanciaDigimon IS NULL THEN raise 'instancia do digimon não encontrada';

ELSE

INSERT INTO batalha (id_instancia_digimon) VALUES
	(idInstanciaDigimon) returning id_batalha INTO idBatalha;

call cria_monstro(idBatalha, nivelInstanciaDigimon);

CALL cria_chefe(
	idBatalha,
	nivelInstanciaDigimon,
	defesa_extra_chefe,
	ataque_extra_chefe,
	vida_extra_chefe,
	velocidade_extra_chefe
);

END IF;

END;

$cria_batalha$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE public.cria_habitante(IN nome character varying, IN eixoX integer, IN eixoY integer)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    idNpc UUID;
   	idRegiaoNpc UUID;
begin	
select "id_regiao" into idRegiaoNpc from regiao where "eixo_x" = eixoX and "eixo_y" = eixoY;
		insert into npc ("nome","id_regiao") values (nome, idRegiaoNpc) returning "id_npc" into idNpc;
		
		insert into habitante ("id_npc")
		values (idNpc);
END;

$procedure$
;


CREATE OR REPLACE PROCEDURE public.cria_guia(IN nome character varying, IN eixoX integer, IN eixoY integer)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    idNpc UUID;
   	idRegiaoNpc UUID;
begin	
select "id_regiao" into idRegiaoNpc from regiao where "eixo_x" = eixoX and "eixo_y" = eixoY;
		insert into npc ("nome","id_regiao") values (nome, idRegiaoNpc) returning "id_npc" into idNpc;
		
		insert into guia  ("id_npc")
		values (idNpc);
END;

$procedure$
;

CREATE OR REPLACE PROCEDURE public.cria_mercador(IN nome character varying, IN eixoX integer, IN eixoY integer, in tipoMercador tipo_mercador)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    idNpc UUID;
   	idRegiaoNpc UUID;
begin	
select "id_regiao" into idRegiaoNpc from regiao where "eixo_x" = eixoX and "eixo_y" = eixoY;
		insert into npc ("nome","id_regiao") values (nome, idRegiaoNpc) returning "id_npc" into idNpc;
		
		insert into mercador  ("id_npc", "tipo")
		values (idNpc, tipoMercador);
END;

$procedure$
;
;