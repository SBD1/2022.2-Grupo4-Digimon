create OR REPLACE PROCEDURE cria_mapa()
as $cria_mapa$

DECLARE
    idMapa UUID;

begin	
	INSERT INTO mapa(altura, largura, descricao)
	VALUES (3, 4, 'Mapa digimon com 12 regioes para explorar!') returning id_mapa into idMapa;
	
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Capitulo perdido',0,0,idMapa);
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Terras Esquecidas',1,0,idMapa);
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Floresta Ecantada',2,0,idMapa);
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Floresta Digital',3,0,idMapa);
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Montanha das Trevas',0,1,idMapa);
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Terra dos Dragões',1,1,idMapa);
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Árvore da Vida',2,1,idMapa);
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Lago dos Sonhos',3,1,idMapa);
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Cidade dos Anjos',0,2,idMapa);
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Terras intermedias',1,2,idMapa);
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Caelid',2,2,idMapa);
	INSERT INTO regiao (nome, eixo_x, eixo_y, id_mapa) VALUES('Reino do Agouro',3,2,idMapa);
END;

$cria_mapa$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE atribui_habilidade_digimon(
	nomeHabilidade text,
	nomeDigimon text
)
as $atribui_habilidade_digimon$

DECLARE
    idHabilidade UUID;
   	idDigimon UUID;

begin	
	
		
	select id_habilidade into idHabilidade from habilidade where nome = nomeHabilidade;

	if idHabilidade is null then
		raise 'Habilidade não encontrada';
	end if;

	select id_digimon into idDigimon from digimon where nome = nomeDigimon;

	if idDigimon is null then
		raise 'Digimon não encontrado';
	end if;


	INSERT INTO digimon_habilidade (id_digimon, id_habilidade) VALUES(idDigimon, idHabilidade);
END;


$atribui_habilidade_digimon$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE cria_ataque(
	nome varchar(20), 
	descricao varchar(255),
	dano integer
)
as $cria_ataque$

DECLARE
    idHabilidade UUID;

begin	
	
	insert into habilidade (nome, descricao, tipo) values (nome, descricao, 'ataque') returning "id_habilidade" into idHabilidade;
		
	insert into ataque (id_habilidade,dano)
	values (idHabilidade, dano);
END;


$cria_ataque$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE cria_defesa(
	nome varchar(20), 
	descricao varchar(255),
	defesa integer
)
as $cria_defesa$

DECLARE
    idHabilidade UUID;

begin	
	
	insert into habilidade (nome, descricao, tipo) values (nome, descricao, 'defesa') returning "id_habilidade" into idHabilidade;
		
	insert into defesa (id_habilidade,defesa)
	values (idHabilidade, defesa);
END;


$cria_defesa$ LANGUAGE plpgsql;

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
		insert into item ("nome", "descricao", "preco_de_venda", "tipo")
		values (nome, descricao, preco_de_venda, 'equipamento') returning "id_item" into idItem;
		
		insert into equipamento ("defesa_extra", "ataque_extra", "vida_extra", "velocidade_extra", "id_item")
		values (defesa_extra,ataque_extra,vida_extra,velocidade_extra, idItem);
END;

$cria_equipamento$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE cria_alimento(
	nome varchar(20), 
	descricao varchar(255),
	preco_de_venda integer DEFAULT 0, 
	nivel integer DEFAULT 0, 
	cura integer DEFAULT 0
	)
as $cria_alimento$

DECLARE
    idItem UUID;
begin
		insert into item ("nome", "descricao", "preco_de_venda", "tipo")
		values (nome, descricao, preco_de_venda, 'alimento') returning "id_item" into idItem;
	
		
		insert into alimento ("nivel", "cura", "id_item")
		values (nivel, cura, idItem);
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
			insert into item ("nome", "descricao", "preco_de_venda", "tipo")
			values (nome, descricao, preco_de_venda, 'chave') returning "id_item" into idItem;
		
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
		insert into categoria_digimon ("tipo") VALUES ('anjo') returning "id_categoria_digimon" into idCategoriaDigimon;
		
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
		insert into categoria_digimon ("tipo") VALUES ('fantasma') returning "id_categoria_digimon" into idCategoriaDigimon;
		
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
		insert into categoria_digimon ("tipo") VALUES ('monge') returning "id_categoria_digimon" into idCategoriaDigimon;
		
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
		insert into categoria_digimon ("tipo") VALUES ('ciborg') returning "id_categoria_digimon" into idCategoriaDigimon;
		
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
		insert into categoria_digimon ("tipo") VALUES ('dragao') returning "id_categoria_digimon" into idCategoriaDigimon;
		
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

create OR REPLACE PROCEDURE cria_digimon(
	nome varchar(20), 
	ataque_por_nivel integer, 
	defesa_por_nivel integer, 
	vida_por_nivel integer, 
	velocidade_por_nivel integer,
	categoria text
)
as $cria_digimon$

DECLARE
    idCategoria UUID;

begin	
	
		
	select id_categoria_digimon into idCategoria from categoria_digimon where tipo::text = categoria;

	if (idCategoria is not null) then 
	
	INSERT INTO digimon (nome, ataque_por_nivel, defesa_por_nivel, vida_por_nivel, velocidade_por_nivel, id_categoria_digimon)
	VALUES(nome, ataque_por_nivel, defesa_por_nivel, vida_por_nivel, velocidade_por_nivel, idCategoria);
	else
		raise 'Tipo de categoria não encontrado';

	end if;
END;


$cria_digimon$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE cria_missao(
	nomeMissao varchar(20), 
	nivel integer, 
	guia text
)
as $cria_missao$

DECLARE
    idGuia UUID;

begin	
	
		
	select id_npc into idGuia from npc where nome = guia;

	if (idGuia is not null) then 
	
	INSERT INTO missao (nome, nivel, id_npc) VALUES(nomeMissao, nivel, idGuia);

	else
		raise 'Guia não encontrado';

	end if;
END;


$cria_missao$ LANGUAGE plpgsql;

create OR REPLACE PROCEDURE cria_dialogo(
	texto varchar(255), 
	nomeNpc text,
	nomeMissao text default ''
)
as $cria_dialogo$

DECLARE
    idNpc UUID;
   	idMissao UUID;

begin	
	
		
	select id_npc into idNpc from npc where nome = nomeNpc;

	if (idNpc is not null) then 
	
	select id_missao into idMissao from missao where nome = nomeMissao;

	INSERT INTO dialogo (texto, id_missao, id_npc) VALUES(texto, idMissao, idNpc);

	else
		raise 'Npc não encontrado';

	end if;
END;


$cria_dialogo$ LANGUAGE plpgsql;

create type dados_digimon as (
	vida integer,
	ataque integer,
	defesa integer,
	velocidade integer
);

CREATE OR REPLACE FUNCTION calcula_dados_digimon(nivel integer, idDigimon UUID) returns dados_digimon as $calcula_dados_digimon$
declare

digimonEncontrado record;
dadosDigimon dados_digimon;

begin
	

select * into digimonEncontrado from digimon join categoria_digimon
on digimon.id_categoria_digimon = categoria_digimon.id_categoria_digimon where digimon.id_digimon = idDigimon;

dadosDigimon = (0,0,0,0);

case 

when digimonEncontrado.tipo = 'anjo' then

select defesa_extra into dadosDigimon.defesa from anjo where id_categoria_digimon = digimonEncontrado.id_categoria_digimon;

when digimonEncontrado.tipo = 'fantasma' then

	select ataque_extra into dadosDigimon.ataque from fantasma where id_categoria_digimon = digimonEncontrado.id_categoria_digimon;

when digimonEncontrado.tipo = 'monge' then

	select vida_extra into dadosDigimon.vida from monge where id_categoria_digimon = digimonEncontrado.id_categoria_digimon;

when digimonEncontrado.tipo = 'ciborg' then

	select velocidade_extra into dadosDigimon.velocidade from ciborg where id_categoria_digimon = digimonEncontrado.id_categoria_digimon;

when digimonEncontrado.tipo = 'dragao' then

	select into dadosDigimon ataque_extra as ataque, defesa_extra as defesa, vida_extra as vida, velocidade_extra as velocidade
	from dragao where id_categoria_digimon = digimonEncontrado.id_categoria_digimon;

end case;

dadosDigimon.vida = digimonEncontrado.vida_por_nivel * nivel + dadosDigimon.vida;
dadosDigimon.ataque = digimonEncontrado.ataque_por_nivel * nivel + dadosDigimon.ataque;
dadosDigimon.defesa = digimonEncontrado.defesa_por_nivel * nivel + dadosDigimon.defesa;
dadosDigimon.velocidade = digimonEncontrado.velocidade_por_nivel * nivel + dadosDigimon.velocidade;

return dadosDigimon;

end;

$calcula_dados_digimon$  LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE cria_monstro(idBatalha UUID, nivel integer) AS $cria_monstro$
 DECLARE 
	idDigimon UUID;
	dadosDigimon dados_digimon;

BEGIN
SELECT id_digimon INTO idDigimon FROM digimon ORDER BY random() LIMIT 1;

select * from calcula_dados_digimon(nivel, idDigimon) into dadosDigimon;

INSERT INTO monstro (nivel, vida_atual, id_digimon, id_batalha, vida, ataque, defesa, velocidade)
VALUES (
	nivel, 
	dadosDigimon.vida, 
	idDigimon, 
	idBatalha, 
	dadosDigimon.vida, 
	dadosDigimon.ataque, 
	dadosDigimon.defesa, 
	dadosDigimon.velocidade
	);

END;

$cria_monstro$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE cria_chefe(
	idBatalha UUID,
	nivel integer,
	defesa_extra_chefe integer DEFAULT 0,
	ataque_extra_chefe integer DEFAULT 0,
	vida_extra_chefe integer DEFAULT 0,
	velocidade_extra_chefe integer DEFAULT 0
) AS $cria_chefe$ 

 DECLARE 
	idDigimon UUID;
	dadosDigimon dados_digimon;
	idMonstro UUID;

BEGIN
SELECT id_digimon INTO idDigimon FROM digimon ORDER BY random() LIMIT 1;

select * from calcula_dados_digimon(nivel, idDigimon) into dadosDigimon;

INSERT INTO
	monstro (nivel, vida_atual, id_digimon, id_batalha, vida, ataque, defesa, velocidade)
VALUES
	(
	nivel, 
	dadosDigimon.vida + vida_extra_chefe, 
	idDigimon, 
	idBatalha, 
	dadosDigimon.vida + vida_extra_chefe, 
	dadosDigimon.ataque + ataque_extra_chefe, 
	dadosDigimon.defesa + defesa_extra_chefe, 
	dadosDigimon.velocidade + velocidade_extra_chefe
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
	idInstanciaDigimon UUID,
	idMissao UUID,
	defesa_extra_chefe integer DEFAULT 0,
	ataque_extra_chefe integer DEFAULT 0,
	vida_extra_chefe integer DEFAULT 0,
	velocidade_extra_chefe integer DEFAULT 0
) AS $cria_batalha$ 

DECLARE idBatalha UUID;

	nivelInstanciaDigimon integer;

BEGIN
	
SELECT nivel INTO nivelInstanciaDigimon
FROM instancia_digimon WHERE id_instancia_digimon = idInstanciaDigimon;

IF nivelInstanciaDigimon IS NULL THEN raise 'instancia do digimon não encontrada';

ELSE

INSERT INTO batalha (id_instancia_digimon, id_missao) VALUES
	(idInstanciaDigimon, idMissao) returning id_batalha INTO idBatalha;

call cria_monstro(idBatalha, nivelInstanciaDigimon - 3);

CALL cria_chefe(
	idBatalha,
	nivelInstanciaDigimon - 3,
	defesa_extra_chefe,
	ataque_extra_chefe,
	vida_extra_chefe,
	velocidade_extra_chefe
);

END IF;

END;

$cria_batalha$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE cria_habitante(nome varchar(20), eixoX integer, eixoY integer)
AS $cria_habitante$

DECLARE
    idNpc UUID;
   	idRegiaoNpc UUID;
begin	
	select "id_regiao" into idRegiaoNpc from regiao where "eixo_x" = eixoX and "eixo_y" = eixoY;
	insert into npc ("nome","id_regiao", "tipo") values (nome, idRegiaoNpc, 'habitante') returning "id_npc" into idNpc;
		
	insert into habitante ("id_npc") values (idNpc);
END;

$cria_habitante$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE cria_guia(nome varchar(20), eixoX integer, eixoY integer)
AS $cria_guia$

DECLARE
    idNpc UUID;
   	idRegiaoNpc UUID;
begin	
	select "id_regiao" into idRegiaoNpc from regiao where "eixo_x" = eixoX and "eixo_y" = eixoY;
	insert into npc ("nome","id_regiao", "tipo") values (nome, idRegiaoNpc, 'guia') returning "id_npc" into idNpc;
		
	insert into guia  ("id_npc") values (idNpc);
END;

$cria_guia$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE cria_mercador(nome varchar(20), eixoX integer, eixoY integer, tipoMercador text)
AS $cria_mercador$

DECLARE
    idNpc UUID;
   	idRegiaoNpc UUID;
begin	

	if (SELECT tipoMercador = any(enum_range(null::tipo_mercador)::text[])) then 
		select "id_regiao" into idRegiaoNpc from regiao where "eixo_x" = eixoX and "eixo_y" = eixoY;
		insert into npc ("nome","id_regiao", "tipo") values (nome, idRegiaoNpc, 'mercador') returning "id_npc" into idNpc;
		
		insert into mercador ("id_npc", "tipo") values (idNpc, tipoMercador::tipo_mercador);
	else
		raise 'Tipo de mercador não existe';

	end if;
END;

$cria_mercador$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE cria_curandeiro(nome varchar(20), eixoX integer, eixoY integer)
AS $cria_curandeiro$

DECLARE
    idNpc UUID;
   	idRegiaoNpc UUID;
begin	
select "id_regiao" into idRegiaoNpc from regiao where "eixo_x" = eixoX and "eixo_y" = eixoY;
		insert into npc ("nome","id_regiao", "tipo") values (nome, idRegiaoNpc, 'curandeiro') returning "id_npc" into idNpc;
		
		insert into curandeiro  ("id_npc")
		values (idNpc);
END;

$cria_curandeiro$ LANGUAGE plpgsql;


-- TRIGGERS

CREATE OR REPLACE FUNCTION inicia_jogo() returns trigger as $inicia_jogo$

DECLARE
    idCategoriaJogador UUID;
    idRegiaoJogador UUID;
begin
 if new.nome is null or new.id_categoria_jogador is null then 
  raise 'dados não informados';
 else
  select "id_categoria_jogador" into idCategoriaJogador from categoria_jogador where "id_categoria_jogador" = new.id_categoria_jogador;
    select "id_regiao" into idRegiaoJogador from regiao where eixo_x  = 0 and eixo_y = 0;
       
    if idCategoriaJogador is null or idRegiaoJogador is null then 
   raise 'dados não encontrados';
  else
  
   new.id_regiao = idRegiaoJogador;
    
   return new;
  end if;
 end if;

END;

$inicia_jogo$ LANGUAGE plpgsql;


CREATE TRIGGER inicia_jogo BEFORE INSERT ON jogador
    FOR EACH ROW EXECUTE FUNCTION inicia_jogo();

CREATE OR REPLACE FUNCTION cria_digivice() returns trigger as $cria_digivice$
begin
	insert into digivice (id_jogador) values (new.id_jogador);

	return new;

END;

$cria_digivice$ LANGUAGE plpgsql;


CREATE TRIGGER cria_digivice after INSERT ON jogador
    FOR EACH ROW EXECUTE FUNCTION cria_digivice();
   
CREATE OR REPLACE FUNCTION verifica_item_mercador() returns trigger as $verifica_item_mercador$

declare

    idMercador UUID;
   
begin
	
  select "id_npc" into idMercador from mercador where id_npc = new.id_npc;
    
   if idMercador is null then 
   
   raise 'Mercador não encontrado';
  
  else
  
   return new;
  
  end if;

END;

$verifica_item_mercador$ LANGUAGE plpgsql;

CREATE TRIGGER verifica_item_mercador BEFORE INSERT ON mercador_item
    FOR EACH ROW EXECUTE FUNCTION verifica_item_mercador();
   
CREATE OR REPLACE FUNCTION verifica_missao() returns trigger as $verifica_missao$

declare

    idGuia UUID;
   
begin
	
  select "id_npc" into idGuia from guia where id_npc = new.id_npc;
    
   if idGuia is null then 
   
   raise 'Guia não encontrado';
  
  else
  
   return new;
  
  end if;

END;

$verifica_missao$ LANGUAGE plpgsql;

CREATE TRIGGER verifica_missao BEFORE INSERT ON missao
    FOR EACH ROW EXECUTE FUNCTION verifica_missao();


CREATE OR REPLACE FUNCTION verifica_equipamento_digimon() returns trigger as $verifica_equipamento_digimon$

declare

    idEquipamento UUID;
   
begin
	
  select "id_item" into idEquipamento from equipamento  where id_item = new.id_item;
    
   if idEquipamento is null then 
   
   raise 'Equipamento não encontrado';
  
  else
  
   return new;
  
  end if;

END;

$verifica_equipamento_digimon$ LANGUAGE plpgsql;

CREATE TRIGGER verifica_equipamento_digimon BEFORE INSERT ON instancia_digimon_instancia_item
    FOR EACH ROW EXECUTE FUNCTION verifica_equipamento_digimon();
   
CREATE OR REPLACE FUNCTION calcula_vida_atual() returns trigger as $calcula_vida_atual$

declare 

dadosDigimon dados_digimon;

begin

	select * from calcula_dados_digimon(new.nivel, new.id_digimon) into dadosDigimon;		

	new.vida_atual = dadosDigimon.vida;
	new.vida = dadosDigimon.vida;
	new.defesa = dadosDigimon.defesa;
	new.ataque = dadosDigimon.ataque;
	new.velocidade = dadosDigimon.velocidade;

	return new;

END;

$calcula_vida_atual$ LANGUAGE plpgsql;

   
CREATE TRIGGER calcula_vida_atual before INSERT ON instancia_digimon
    FOR EACH ROW EXECUTE FUNCTION calcula_vida_atual();
    
CREATE TRIGGER calcula_vida_atual_ao_upar before update of nivel ON instancia_digimon
    FOR EACH ROW EXECUTE FUNCTION calcula_vida_atual();
    
CREATE OR REPLACE FUNCTION verifica_missao_jogador() returns trigger as $verifica_missao_jogador$

begin

	if (select count(*) from missao_jogador 
	where id_jogador = new.id_jogador and concluida = false) then 

		raise 'Já existe uma missão em andamento';
	
	else
		return new;	
	
	end if;

END;

$verifica_missao_jogador$ LANGUAGE plpgsql;

   
CREATE TRIGGER verifica_missao_jogador before insert ON missao_jogador
    FOR EACH ROW EXECUTE FUNCTION verifica_missao_jogador();



CREATE OR REPLACE FUNCTION verifica_instancia_item() returns trigger as $verifica_instancia_item$

declare 

	instanciaEncontrada UUID;

begin

	select id_instancia_item into instanciaEncontrada from instancia_item 
	where id_item = new.id_item and id_digivice = new.id_digivice;

	if instanciaEncontrada is not null then 

		update instancia_item set quantidade = quantidade + new.quantidade where id_instancia_item = instanciaEncontrada;
	
		return null;
	
	else
		return new;	
	
	end if;

END;

$verifica_instancia_item$ LANGUAGE plpgsql;

   
CREATE TRIGGER verifica_instancia_item before insert ON instancia_item
    FOR EACH ROW EXECUTE FUNCTION verifica_instancia_item();

-- FUNCTION COM TRANSACTION    
CREATE OR REPLACE FUNCTION termina_batalha() returns trigger as $termina_batalha$

declare 

	vidaDigimon integer;
	idDigivice UUID;
	idJogador UUID;

begin

	-- A instrução SET TRANSACTION pode ser usada para alterar o comportamento da transação atual. 
	-- O ISOLATION LEVEL READ COMMITTED define o nível de isolamento da transação atual para leitura confirmada, 
	-- o que significa que quaisquer alterações de dados feitas por outras transações serão visíveis para a transação atual.
	set transaction isolation level read committed;

	select vida_atual, id_digivice into vidaDigimon, idDigivice from instancia_digimon 
	where instancia_digimon.id_instancia_digimon = old.id_instancia_digimon;		

	if vidaDigimon > 0 then
	
		update jogador set vitorias = vitorias + 1 where id_jogador = (
		select id_jogador from digivice where id_digivice = idDigivice) returning id_jogador into idJogador;
					
		update instancia_digimon set nivel = nivel + (select nivel from missao where id_missao = old.id_missao)
		where id_instancia_digimon = old.id_instancia_digimon;
		
		insert into instancia_item (id_digivice, id_item) (
			select idDigivice as id_digivice ,id_item from missao_item where id_missao = old.id_missao
		);
					
		update missao_jogador set concluida = true where id_missao = old.id_missao and id_jogador = idJogador;

	else
	
		update jogador set derrotas = derrotas + 1 where id_jogador = (
		select id_jogador from digivice where id_digivice = idDigivice);

	end if;

	delete from chefe using monstro where chefe.id_monstro = monstro.id_monstro and monstro.id_batalha = old.id_batalha;
	delete from monstro where monstro.id_batalha = old.id_batalha;
	
	return old;

END;

$termina_batalha$ LANGUAGE plpgsql;

   
CREATE TRIGGER termina_batalha before DELETE ON batalha
    FOR EACH ROW EXECUTE FUNCTION termina_batalha();