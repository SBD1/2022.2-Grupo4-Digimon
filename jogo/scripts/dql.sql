-- jogador -> criar jogador
SELECT * FROM categoria_jogador
INSERT INTO jogador(nome, id_categoria_jogador,id_regiao) VALUES('${nomeJogador}', '${id_categoria_jogador}', 'c7bedb33-9534-4956-bc4b-cb5f7c2260da')

-- jogador -> get regiao
SELECT * FROM regiao where id_regiao = '${jogadorCriado.id_regiao}'

-- jogador -> movimenta jogador
SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x - 1})  AND (eixo_y = ${posicao_y})
SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x + 1})  AND (eixo_y = ${posicao_y})
SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x})  AND (eixo_y = ${posicao_y + 1})
SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x})  AND (eixo_y = ${posicao_y - 1})

-- jogador -> atualiza reagio jogador
UPDATE jogador SET id_regiao = '${idRegiao}' WHERE id_jogador = '${jogadorCriado.id_jogador}' RETURNING *