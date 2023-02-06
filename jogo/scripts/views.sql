create or replace view view_instancia_digimon as select 
d.nome, cd.tipo,id.id_digimon, id.vida_atual, id.nivel, id.vida, id.defesa, id.ataque, id.velocidade, id.id_instancia_digimon, id.id_digivice 
from instancia_digimon id 
join digimon d on d.id_digimon = id.id_digimon 
join categoria_digimon cd on d.id_categoria_digimon = cd.id_categoria_digimon;

create or replace  view view_monstro as select 
d.nome, cd.tipo,m.id_digimon, m.vida_atual, m.nivel, m.vida, m.defesa, m.ataque, m.velocidade, m.id_monstro, m.id_batalha 
from monstro m
join digimon d on d.id_digimon = m.id_digimon 
join categoria_digimon cd on d.id_categoria_digimon = cd.id_categoria_digimon;

