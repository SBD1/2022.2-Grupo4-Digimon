-- Tabala Categoria Jogador

INSERT INTO public.categoria_jogador(id_categoria_jogador, historia, tipo)
VALUES (uuid_generate_v4(), 'Nobre guerreiro que almeja derrotas os mais temiveis monstros e inimigos no mundo Digimon.', 'Duelista');

INSERT INTO public.categoria_jogador(id_categoria_jogador, historia, tipo)
VALUES (uuid_generate_v4(), 'Conhecido pelo grande suporte que fez nas batalhas antigas e pelos feitos ajudando os aliados.', 'Suporte');

INSERT INTO public.categoria_jogador(id_categoria_jogador, historia, tipo)
VALUES (uuid_generate_v4(), 'Uma vasta mistura de ambos, Possui destreza para duelos alem de conseguir');


--Mapa do jogo
INSERT INTO public.mapa(id_mapa, altura, largura, descricao)
VALUES (uuid_generate_v4(), 3, 4, 'Mapa digimon com 12 regioes para explorar!');


-- Regioes do jogo presente dentro do mapa
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Capitulo perdido',1,1,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Terras Esquecidas',2,1,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Floresta Ecantada',3,1,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Floresta Digital',4,1,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Montanha das Trevas',1,2,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Terra dos Dragões',2,2,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Árvore da Vida',3,2,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Lago dos Sonhos',4,2,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Cidade dos Anjos',1,3,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Terras intermedias',2,3,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Caelid',3,3,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Reino do Agouro',4,3,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');

-- 
