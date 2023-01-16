# Diagrama Relacional (MER)

## Modelo Entidade-Relacionamento

### Entidades

- Jogador
    - id_jogador
    - nome
    - vitorias
    - derrotas
    - dinheiro

- Digivice
    - id_digivice

- NPC
    - id_npc
    - nome

- Missão
    - id_missao
    - nome
    - experiencia

- Dialogo
    - id_dialogo
    - texto

- Mercador
    - tipo

- Região
    - id_regiao
    - nome
    - eixo_x
    - eixo_y

- Item
    - id_item
    - nome
    - preco_de_venda
    - descricao

- Instancia_item
    - id_instancia_item
    - quantidade

- Digimon
    - id_digimon
    - nome
    - ataque_por_nivel
    - defesa_por_nivel
    - vida_por_nivel
    - velocidade_por_nivel

- Instancia_Digimon
    - id_instancia_digimon
    - nivel
    - ataque
    - defesa
    - vida
    - velocidade
    - vida_atual

- Habilidade
    - id_habilidade
    - nome
    - descricao

- Monstro
    - nivel
    - ataque
    - defesa
    - vida
    - velocidade
    - vida_atual

### Atributos

#### 
**Jogador**: <ins>id_jogador</ins>, nome, vitorias, derrotas, dinheiro;

**Digivice**: <ins>id_digivice</ins>;

**NPC**: <ins>id_npc</ins>, nome

**Missão**: <ins>id_missao</ins>, nome, experiencia

**Dialogo**: <ins>id_dialogo</ins>, texto

**Mercador**: tipo

**Região**: <ins>id_regiao</ins>, nome, eixo_x, eixo_y

**Item**: <ins>id_item</ins>, nome, preco_de_venda, descricao

**Instancia_item**: <ins>id_instancia_item</ins>, quantidade

**Digimon**: <ins>id_digimon</ins>, nome, ataque_por_nivel, defesa_por_nivel, vida_por_nivel, velocidade_por_nivel

**Instancia_Digimon**: <ins>id_instancia_digimon</ins>, nivel, ataque, defesa, vida, velocidade, vida_atual

**Habilidade**: <ins>id_habilidade</ins>, nome, descricao

**Monstro**: nivel, ataque, defesa, vida, velocidade, vida_atual



### Relacionamentos

<!-- ![Diagrama Relacional](diagrama_images/diagrama_relacional.png "Diagrama Relacional") -->