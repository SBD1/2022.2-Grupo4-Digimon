-- Cria usuario restrito para acessar o jogo
CREATE USER jogador_usuario WITH PASSWORD process.env.PG_PASSWORD;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE categoria_jogador to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE jogador to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE regiao to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE batalha to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE monstro to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE chefe  to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE digimon to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE instancia_digimon to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE digivice to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE instancia_item to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE missao to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE missao_jogador to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE npc to jogador_usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE dialogo to jogador_usuario;
REVOKE ALL PRIVILEGES ON TABLE categoria_jogador, jogador, regiao, batalha, monstro, 
                                chefe, digimon, instancia_digimon , digivice, instancia_item, 
                                missao, missao_jogador, npc, dialogo  FROM PUBLIC;