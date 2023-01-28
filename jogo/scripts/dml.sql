-- Tabala Categoria Jogador

INSERT INTO public.categoria_jogador(id_categoria_jogador, historia, tipo)
VALUES (uuid_generate_v4(), 'Nobre guerreiro que almeja derrotas os mais temiveis monstros e inimigos no mundo Digimon.', 'Duelista');

INSERT INTO public.categoria_jogador(id_categoria_jogador, historia, tipo)
VALUES (uuid_generate_v4(), 'Conhecido pelo grande suporte que fez nas batalhas antigas e pelos feitos ajudando os aliados.', 'Suporte');

INSERT INTO public.categoria_jogador(id_categoria_jogador, historia, tipo)
VALUES (uuid_generate_v4(), 'Uma vasta mistura de ambos, Possui destreza para duelos alem de conseguir');


-- Mapa do jogo
INSERT INTO public.mapa(id_mapa, altura, largura, descricao)
VALUES (uuid_generate_v4(), 3, 4, 'Mapa digimon com 12 regioes para explorar!');


-- Regioes do jogo presente dentro do mapa
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Capitulo perdido',0,0,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Terras Esquecidas',1,0,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Floresta Ecantada',2,0,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Floresta Digital',3,0,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Montanha das Trevas',0,1,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Terra dos Dragões',1,1,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Árvore da Vida',2,1,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Lago dos Sonhos',3,1,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Cidade dos Anjos',0,2,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Terras intermedias',1,2,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Caelid',2,2,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');
INSERT INTO public.regiao (id_regiao, nome, eixo_x, eixo_y, id_mapa) VALUES(uuid_generate_v4(),'Reino do Agouro',3,2,'9a3b49c8-dc1d-4c3a-a5b5-5c5e5d5f6a7b');

-- Utilizacao de Stored Procedures
call cria_alimento('biscoito', 'doce', 10, 1); --(nome,descricao,preco_de_venda,experiencia,cura) cura foi omitido por que quando não é mandado o defalt é 0
call cria_alimento('framboesa', 'fruta', 5, 1, 1);
call cria_chave('chave bendita', 'chave para desbloquear as portas do ceu', 'A');
call cria_chave('chave maldita', 'chave para desbloquear as portas do inferno', 'B');
call cria_equipamento('anel', 'joia', 20, 10, 10, 2, 2);
call cria_equipamento('espada', 'armamento', 50, 0, 20, 0, 0);
call cria_equipamento('escudo', 'protecao', 40, 20, 0, 0, 0);

call cria_monge(10) --atributo de vida por nivel, ou seja aumentara 10 a cada nivel evoluido.
call cria_anjo(8); -- atributo de defesa por nivel, ou seja aumentara 8 a cada nivel evoluido.
call cria_ciborg(10); -- atributo de velocidade por nivel.
call cria_dragao(7, 7, 7, 7); -- atributos de defesa, ataque, vida, velocidae. todos por niveis.
call cria_fantasma(12); -- atributo de ataque por nivel.

call cria_guia('Mestre antigo', 0, 0);
call cria_habitante('kleber',3,2);
call cria_habitante('velho de caelid',3,2);
call cria_mercador ('Kleber do fuzil', 0,0, 'comerciante de armas'::tipo_mercador);


