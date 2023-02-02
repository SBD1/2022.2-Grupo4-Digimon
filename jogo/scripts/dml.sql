INSERT INTO categoria_jogador(historia, tipo)
VALUES ('Nobre guerreiro que almeja derrotas os mais temiveis monstros e inimigos no mundo Digimon.', 'Duelista');

INSERT INTO categoria_jogador(historia, tipo)
VALUES ('Conhecido pelo grande suporte que fez nas batalhas antigas e pelos feitos ajudando os aliados.', 'Suporte');

INSERT INTO categoria_jogador(historia, tipo)
VALUES ('Uma vasta mistura de ambos, Possui destreza para duelos alem de conseguir', 'Conservador');

call cria_mapa();

call cria_alimento('biscoito', 'doce', 10, 1);
call cria_alimento('framboesa', 'fruta', 5, 1, 1);
call cria_chave('chave bendita', 'chave para desbloquear as portas do ceu', 'A');
call cria_chave('chave maldita', 'chave para desbloquear as portas do inferno', 'B');
call cria_equipamento('anel', 'joia', 20, 10, 10, 2, 2);
call cria_equipamento('espada', 'armamento', 50, 0, 20, 0, 0);
call cria_equipamento('escudo', 'protecao', 40, 20, 0, 0, 0);

call cria_monge(10); 
call cria_anjo(8); 
call cria_ciborg(10); 
call cria_dragao(7, 7, 7, 7); 
call cria_fantasma(12); 

call cria_digimon('Angemon', 10, 20, 100, 10, 'anjo');
call cria_digimon('Pidmon', 10, 18, 100, 8, 'anjo');
call cria_digimon('Fantomon', 15, 25, 100, 15, 'fantasma');
call cria_digimon('Bakemon', 13, 23, 100, 13, 'fantasma');
call cria_digimon('Sanzomon', 17, 15, 100, 10, 'monge');
call cria_digimon('Mongomon', 15, 15, 100, 8, 'monge');
call cria_digimon('MegaloGrowmon', 10, 10, 100, 15, 'ciborg');
call cria_digimon('Andromon', 12, 12, 100, 12, 'ciborg');
call cria_digimon('Dracomon', 20, 20, 100, 20, 'dragao');
call cria_digimon('', 18, 18, 100, 18, 'dragao');

call cria_guia('Mestre antigo', 0, 0);
call cria_habitante('Kleber', 1, 0);
call cria_habitante('Steve', 2, 0);
call cria_mercador ('Hanna', 3, 0, 'vendedor de frutas');
call cria_curandeiro('Sage', 0, 1);
call cria_guia('Omen', 1, 1);
call cria_curandeiro('Jesse', 2, 1);
call cria_habitante('Hank', 3, 1);
call cria_mercador ('Heisenberg', 0, 2, 'comerciante de armas');
call cria_curandeiro('Eleven', 1, 2);
call cria_habitante('Velho de Caelid', 2, 2);
call cria_guia('Bill Gates', 3, 2);

call cria_missao('Salvar digimons', 10, 'Mestre antigo');
call cria_missao('Libertar a princesa', 15, 'Omen');
call cria_missao('Encontrar as chaves', 20, 'Bill Gates');

call cria_dialogo(
	'Ola companheiro, vou te guiar para a mais nobre missao de salvar pequenos digimons perdidos de sua familia de alguns capangas. Esta pronto?', 
	'Mestre antigo',
	'Salvar digimons'
);

call cria_dialogo(
	'Ola, sabia que Akiyoshi Hongo foi o criador de Digimon, porém, a verdade é que essa pessoa é um pseudônimo criado pela Bandai para creditar os 3 responsáveis pela origem da franquia: Aki Maita, Hiroshi Izawa e Takeichi Hongo.', 
	'Kleber'
);

call cria_dialogo(
	'Oi, sabia que a principal influência de Digimon, não é Pokémon, mas sim Tamagotchi, aquelas criaturinhas virtuais que vivem em pequenos aparelhos para serem cuidados junto ao seus donos.', 
	'Steve'
);
call cria_dialogo(
	'Bem vindo a minha loja, aqui voce encontra os melhores alimentos para se preparar para qualquer batalha.', 
	'Hanna'
);
call cria_dialogo(
	'Ola fracote, precisa de ajuda? Vou te curar por completo', 
	'Sage'
);
call cria_dialogo(
	'Salve aventureiro, precisamos de ajuda para libertar a princesa Isabel, lute com os digimons do mal para ajuda-la!', 
	'Omen', 
	'Libertar a princesa'
);
call cria_dialogo(
	'Guerreiro, consigo recuperar 50% da sua vida, vamos nessa!', 
	'Jesse'
);
call cria_dialogo(
	'Amigao, sabia que os nomes dos principais Digimon foram derivados de palavras japonesas?', 
	'Hank'
);
call cria_dialogo(
	'Bem vindo ao melhor local para se armar, aqui temos todos os equipamento para te proteger e te ajudar nas batalhas por um preco justo!', 
	'Heisenberg'
);
call cria_dialogo(
	'Hi, vou te dar um beijinho e logo logo voce tera 70% da sua vida novamente hihihi.', 
	'Eleven'
);
call cria_dialogo(
	'Opa, sabia que em Digimon: O Filme, quando o DigiOvo emerge do computador, o texto no fundo da cena é o Salmo 109 da Bíblia Sagrada?', 
	'Velho de Caelid'
);
call cria_dialogo(
	'Compatriota, vou te mostrar o portal para voce encontrar as chaves para lutar com o boss, mas primeiro voce precisa lutar com um vilao, vamo que vamo!', 
	'Bill Gates', 
	'Encontrar as chaves'
);

call cria_ataque('Bola de Fogo', 'Lança uma corrente de chama azul', 70);
call cria_defesa('Casca Grossa', 'Ganha um fortalecimento em sua casca', 25);
call atribui_habilidade_digimon('Bola de Fogo', 'Angemon');
call atribui_habilidade_digimon('Casca Grossa', 'Angemon');

call cria_ataque('Pequeno Chifre', 'Ataca com seu chifre em sua cabeça', 65);
call cria_defesa('Escudo de Rocha', 'Invoca um escudo de pedras ao seu redor', 30);
call atribui_habilidade_digimon('Pequeno Chifre', 'Pidmon');
call atribui_habilidade_digimon('Escudo de Rocha', 'Pidmon');

call cria_ataque('Ciclone Azul', 'Gira em torno de si enquanto solta um fogo azul', 60);
call cria_defesa('Capuz da Morte', 'Usa seu capuz de defesa ultra resistente', 35);
call atribui_habilidade_digimon('Ciclone Azul', 'Fantomon');
call atribui_habilidade_digimon('Capuz da Morte', 'Fantomon');

call cria_ataque('Jato Mágico', 'Atira um jato de agua extremamente forte', 55);
call cria_defesa('Bandana de Mercúrio', 'Remove os efetos de ataque recebidos', 40);
call atribui_habilidade_digimon('Jato Mágico', 'Bakemon');
call atribui_habilidade_digimon('Bandana de Mercúrio', 'Bakemon');

call cria_ataque('Furação Espiral', 'Conjura o maior furação já visto contra o inímigo', 50);
call cria_defesa('Escudo Relicário', 'bla bla bla', 45);
call atribui_habilidade_digimon('Furação Espiral', 'Sanzomon');
call atribui_habilidade_digimon('Escudo Relicário', 'Sanzomon');

call cria_ataque('Raio Congelante', 'bla bla bla', 45);
call cria_defesa('Coração Congelado', 'bla bla bla', 50);
call atribui_habilidade_digimon('Raio Congelante', 'Mongomon');
call atribui_habilidade_digimon('Coração Congelado', 'Mongomon');

call cria_ataque('Choque do Trovão', 'bla bla bla', 40);
call cria_defesa('Placa Gargolítica', 'bla bla bla', 55);
call atribui_habilidade_digimon('Choque do Trovão', 'MegaloGrowmon');
call atribui_habilidade_digimon('Placa Gargolítica', 'MegaloGrowmon');

call cria_ataque('Erva Venenosa', 'bla bla bla', 35);
call cria_defesa('Colheita Feliz', 'bla bla bla', 60);
call atribui_habilidade_digimon('Erva Venenosa', 'Andromon');
call atribui_habilidade_digimon('Colheita Feliz', 'Andromon');

call cria_ataque('Tiro de Canhão', 'bla bla bla', 30);
call cria_defesa('Armaguarda Caçadora', 'bla bla bla', 65);
call atribui_habilidade_digimon('Tiro de Canhão', 'Dracomon');
call atribui_habilidade_digimon('Armaguarda Caçadora', 'Dracomon');


call cria_ataque('Eletro Choque', 'bla bla bla', 25);
call cria_defesa('Máscara Abissal', 'bla bla bla', 70);
call atribui_habilidade_digimon('Eletro Choque', 'Peledramon');
call atribui_habilidade_digimon('Máscara Abissal', 'Peledramon');