create or replace view view_instancia_digimon as select 
d.nome, cd.tipo, id.vida_atual, id.nivel, id.vida, id.defesa, id.ataque, id.velocidade, id.id_instancia_digimon, id.id_digivice, max(a.dano) as dano_habilidade, max(def.defesa) as defesa_habilidade
from instancia_digimon id 
join digimon d on d.id_digimon = id.id_digimon 
join categoria_digimon cd on d.id_categoria_digimon = cd.id_categoria_digimon
join digimon_habilidade dh on dh.id_digimon = d.id_digimon 
left join ataque a on a.id_habilidade = dh.id_habilidade
left join defesa def on def.id_habilidade = dh.id_habilidade
group by nome, tipo, id.vida_atual, id.nivel, id.vida, id.defesa, id.ataque, id.velocidade, id.id_instancia_digimon, id.id_digivice;


create or replace  view view_monstro as select 
d.nome, cd.tipo, m.vida_atual, m.nivel, m.vida, m.defesa, m.ataque, m.velocidade, m.id_monstro, m.id_batalha, b.id_instancia_digimon , max(a.dano) as dano_habilidade, max(def.defesa) as defesa_habilidade
from monstro m
join digimon d on d.id_digimon = m.id_digimon 
join categoria_digimon cd on d.id_categoria_digimon = cd.id_categoria_digimon
join digimon_habilidade dh on dh.id_digimon = d.id_digimon 
join batalha b on b.id_batalha = m.id_batalha 
left join ataque a on a.id_habilidade = dh.id_habilidade
left join defesa def on def.id_habilidade = dh.id_habilidade
group by d.nome, cd.tipo, m.vida_atual, m.nivel, m.vida, m.defesa, m.ataque, m.velocidade, m.id_monstro, m.id_batalha, b.id_instancia_digimon;