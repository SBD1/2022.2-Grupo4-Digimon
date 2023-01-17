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

**Jogador**: <ins>id_jogador</ins>, nome, vitorias, derrotas, dinheiro;

**Digivice**: <ins>id_digivice</ins>;

**NPC**: <ins>id_npc</ins>, nome;

**Missão**: <ins>id_missao</ins>, nome, experiencia;

**Dialogo**: <ins>id_dialogo</ins>, texto;

**Mercador**: tipo;

**Região**: <ins>id_regiao</ins>, nome, eixo_x, eixo_y;

**Item**: <ins>id_item</ins>, nome, preco_de_venda, descricao;

**Instancia_item**: <ins>id_instancia_item</ins>, quantidade;

**Digimon**: <ins>id_digimon</ins>, nome, ataque_por_nivel, defesa_por_nivel, vida_por_nivel, velocidade_por_nivel;

**Instancia_Digimon**: <ins>id_instancia_digimon</ins>, nivel, ataque, defesa, vida, velocidade, vida_atual;

**Habilidade**: <ins>id_habilidade</ins>, nome, descricao;

**Monstro**: nivel, ataque, defesa, vida, velocidade, vida_atual.


### Relacionamentos

#### Jogador - está - Região
- Um <em>Jogador</em> **está** em uma <em>Região</em>. Cardinalidade (1 : 1);
- A Região pode conter um Jogador. Cardinalidade (0 : 1);

#### Jogador - possui - Digivice
- Um Jogador possuir um Digivice. Cardinalidade (1 : 1)
- Um Digivice é possído por um Jogador. Cardinalidade (1 : 1)

#### Jogador - possui - Categoria
- Um Jogador possui uma Categoria. Cardinalidade (1 : 1)
- Uma Categoria pode contér nenhum ou vários Jogador(s). Cardinalidade (0 : N)

#### Jogador - realiza - Missão REALIZA??

#### Digivice - possui - Instancia_Item
- Digivice pode possuir nenhum ou várias Instancia_Item(s). Cardinalidade (0 : N)
- Instancia_Item é armazenada em um Digivice. Cardinalidade (1 : 1)

#### Digivice - armazena - Instancia_Digimon
- Digivice pode possuir um ou várias Instancia_Digimon(s). Cardinalidade (1 : N)
- Instancia_Digimon é armazenada em um Digivice. Cardinalidade (1 : 1)

#### Instancia_Digimon - referencia - Digimon
- Instancia_Digimon referencia um Digimon. Cardinalidade (1 : 1)
- Digimon pode ser referenciado por nenhum ou várias Instancia_Digimon(s). Cardinalidade (0 : N)

#### Instancia_Digimon - participa - Batalha
- Instancia_Digimon pode participar de nenhuma ou várias batalhas. Cardinalidade (0 : N)
- Batalha deve ter uma Instancia_Digimon. Cardinalidade (1 : 1)

#### Instancia_Digimon - usa - Instancia_Item
- Instancia_Digimon pode usar nenhuma ou várias Instancia_Item(s). Cardinalidade (0 : N)
- Instancia_Item deve ser usada por uma Instancia_Digimon. Cardinalidade (1 : 1)

#### Instancia_Item - refencia - Item
- Instancia_Digimon referencia um Item. Cardinalidade (1 : 1)
- Item pode ser referenciado por nenhum ou várias Instancia_Digimon(s). Cardinalidade (0 : N)

#### Missao - possui - Dialogo
- Missao pode possuir nenhum ou várias Dialogo(s). Cardinalidade (0 : N)
- Item pode ser referenciado por nenhum ou várias Instancia_Digimon(s). Cardinalidade (0 : N)

#### Missao - entrega - Item
- Missao pode entregar nenhum ou vários Item(S). Cardinalidade (0 : N)
- Item pode ser entregue por nenhuma ou várias Missao(s). Cardinalidade (0 : N)

#### NPC - esta - Regiao
- NPC deve estar em uma Regiao. Cardinalidade (1 : 1)
- Regiao pode conter nenhum ou vários NPC(s). Cardinalidade (0 : N)

#### NPC - realiza - Dialogo
- NPC pode realizar nenhum ou vários Dialogos(s). Cardinalidade (0 : N)
- Dialogo pode ser realizado por nenhum ou um NPC. Cardinalidade (0 : 1)

#### Digimon - possui - Habilidade
- Digimon pode possuir nenhum ou várias Habilidade(s). Cardinalidade (0 : N)
- Habilidade pode usada por nenhum ou váriaos Digimon(s). Cardinalidade (0 : N)

#### Digimon - possui - Categoria
- Um Digimon possui uma Categoria. Cardinalidade (1 : 1)
- Uma Categoria pode contér nenhum ou vários Digimon(s). Cardinalidade (0 : N)

#### Monstro - referencia - Digimon
- Monstro referencia um Digimon. Cardinalidade (1 : 1)
- Digimon pode ser referenciado por nenhum ou várias Monstro(s). Cardinalidade (0 : N)

#### Monstro - participa - Batalha

#### Batalha - recompensa - Item

#### Mapa - contém - Região

#### Região - conecta - Região

### VENDE??


<!-- ![Diagrama Relacional](diagrama_images/diagrama_relacional.png "Diagrama Relacional") -->