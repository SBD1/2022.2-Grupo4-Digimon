-- jogador
SELECT * FROM categoria_jogador
INSERT INTO jogador(nome, id_categoria_jogador,id_regiao) VALUES('${nomeJogador}', '${id_categoria_jogador}', 'c7bedb33-9534-4956-bc4b-cb5f7c2260da')
SELECT * FROM jogador WHERE nome = '${nomeJogador}'
SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x - 1})  AND (eixo_y = ${posicao_y})
SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x + 1})  AND (eixo_y = ${posicao_y})
SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x})  AND (eixo_y = ${posicao_y + 1})
SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x})  AND (eixo_y = ${posicao_y - 1})
UPDATE jogador SET id_regiao = '${idRegiao}' WHERE id_jogador = '${jogadorCriado.id_jogador}' RETURNING *

-- batalha
call cria_batalha('${instanciaDigimon.id_instancia_digimon}')
select * from batalha join monstro on batalha.id_batalha = monstro.id_batalha join digimon d on d.id_digimon = monstro.id_digimon where batalha.id_instancia_digimon = '${instanciaDigimon.id_instancia_digimon}'
delete from batalha where id_batalha = '${resMonstros.rows[0].id_batalha}'
update ${isMonster ? 'monstro' : 'instancia_digimon'} set vida_atual = vida_atual
         - (select ataque.dano from ataque join digimon_habilidade dh on dh.id_habilidade = ataque.id_habilidade
         where dh.id_digimon = '${atacante.id_digimon}') - ${atacante.ataque} where 
         ${isMonster ? 'id_monstro' : 'id_instancia_digimon'} = '${isMonster ? defendente.id_monstro : defendente.id_instancia_digimon}' returning vida_atual
update ${isMonster ? 'monstro' : 'instancia_digimon'} set vida_atual = vida_atual
         + (select defesa.defesa from defesa join digimon_habilidade dh on dh.id_habilidade = defesa.id_habilidade
         where dh.id_digimon = '${atacante.id_digimon}') + ${atacante.defesa} where 
         ${isMonster ? 'id_monstro' : 'id_instancia_digimon'} = '${isMonster ? atacante.id_monstro : atacante.id_instancia_digimon}' returning vida_atual

-- digimon
SELECT * FROM digimon where id_digimon = '${digimon.id_digimon}'
SELECT * FROM digimon d  ORDER BY RANDOM() LIMIT 2
INSERT INTO public.instancia_digimon (nivel, id_digimon, id_digivice) VALUES(5, '${digimon.id_digimon}', '${digivice.id_digivice}');
UPDATE public.instancia_digimon SET vida_atual = 100 WHERE id_digivice = '${digivice.id_digivice}' AND id_digimon = '${digimon.id_digimon}'

-- digivice
select id_digivice from digivice where id_jogador = '${jogadorAtualziado.id_jogador}'
select * from instancia_digimon where id_digivice = '${digivice.id_digivice}'
select * from instancia_item where id_digivice = '${digivice.id_digivice}'

-- missao
select * from missao where id_npc = '${npc.id_npc}'
select * from missao_jogador where id_missao = '${missao.id_missao}' and id_jogador = '${jogadorAtualziado.id_jogador}'
insert into missao_jogador(id_missao, id_jogador, concluida) values('${missao.id_missao}', '${jogadorAtualziado.id_jogador}', false)

-- npc
SELECT * FROM npc WHERE id_regiao = '${regiao.id_regiao}'
SELECT * FROM dialogo WHERE id_npc = '${npc.id_npc}'

-- regiao
SELECT * FROM regiao where id_regiao = '${jogadorCriado.id_regiao}'