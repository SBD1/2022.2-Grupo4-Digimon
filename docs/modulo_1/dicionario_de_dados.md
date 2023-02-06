# Dicionário de Dados

## Entidade: jogador
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_jogador  | Determinante  | uuid  | 35 | Número de identificação do jogador | 0001 |
| nome  | Simples  | varchar  | 20 | Apelido do jogador | Pedro21 |
| vitorias  | Simples  | int  | 6 | Vitórias do jogador | 123433 |
| derrotas  | Simples  | int  | 6 | Derrotas do jogador | 432144 |
| dinheiro | Simples  | int  | 6 | Vitória contra monstros digimon | 100000 |


## Entidade: categoria_jogador
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_categoria  | Determinante  | uuid  | 35 | Número de identificação da categoria | 0001 |
| historia  | Simples  | varchar  | 255 | História do jogador | Meu nome é pedro e gosto muito de digimon. |
| tipo  | Simples  | enum | 6 | Tipo do jogador | Duelista, Conversador, Suporte |

## Entidade: regiao
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_regiao  | Determinante  | uuid  | 35| Número de identificação da região | 0001 |
| nome  | Simples  | varchar  | 20 | nome da região | Loja |
| eixo_x | Simples | int | 1 | Coordenada do objeto no eixo x | No mínimo: 0 e No máximo: 3 |
| eixo_y | Simples | int | 1 | Coordenada do objeto no eixo y | No mínimo: 0 e No máximo: 2 |

## Entidade: mapa
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_mapa  | Determinante  | uuid  | 35 | Número de identificação do mapa | 0014 |
| altura | Simples | int | 4 | Altura do mapa | 2 |
| largura | Simples | int | 4 | Largura do mapa | 100 |
| descricao | Simples | varchar | 255 | Descrição sobre o mapa | Mapa com montanhas. |

## Entidade: realiza
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_realiza  | Determinante  | uuid  | 35 | Número de identificador ação | 0023 |
| concluida | Simples | bool | 1 | Se a missão foi realizada ou não | true |

 
## Entidade: missao
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_missao  | Determinante  | uuid  | 35 | Número de identificador da missão | 9013 |
| nome | Simples | varchar | 20 | Nome da missão | Pegue seu digivice |
| nivel | Simples | int | 6 | Experiencia que a missão vai dar ao ser concluída | 230000 |

## Entidade: dialogo
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_dialogo  | Determinante  | uuid  | 35 | Número de identificador do diólogo | 5345 |
| texto | Simples | varchar | 255 | Texto do dialogo | Oi tudo bem? |

## Entidade: npc
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_npc  | Determinante  | uuid  | 35 | Número de identificador do npc | 6465 |
| nome | Simples | varchar | 20 | Nome do npc| Jorge |


## Entidade: habitante
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_npc  | Determinante  | uuid  | 35 | Número de identificador do npc | 6465 |
| nome | Simples | varchar | 20 | Nome do npc | João |


## Entidade: guia
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_npc  | Determinante  | uuid | 35 | Número de identificador do npc | 6465 |
| nome | Simples | varchar | 20 | Nome do npc| Pedro |


## Entidade: mercador
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_npc  | Determinante  | uuid  | 35 | Número de identificador do mercador | 6465 |
| nome | Simples | varchar | 20 | Nome do npc| Pedro |
| tipo | Simples | enum | 6 | Tipo de mercador | Mercador de armas |

## Entidade: armeiro
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_npc  | Determinante  | uuid  | 35 | Número de identificador do mercador | 6465 |
| nome | Simples | varchar | 20 | Nome do npc| Pedro |
| tipo | Simples | enum | 6 | Tipo de mercador | Mercador de armas |

## Entidade: fruteiro
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_npc  | Determinante  | uuid  | 35 | Número de identificador do mercador | 6465 |
| nome | Simples | varchar | 20 | Nome do npc| Pedro |
| tipo | Simples | enum | 6 | Tipo de mercador | Mercador de armas |

## Entidade: vende
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_venda  | Determinante  | uuid  | 35 | Número de identificador da venda | 6465 |
| preco | Simples | int | 6 | Preço do item | s150 |

## Entidade: item
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_item  | Determinante  | uuid  | 35 | Número de identificador do item | 6465 |
| nome | Simples | int | 6 | Nome do item | espada |
| preco_de_venda  | simples  | int  | 6 | Valor da venda | 6465 |
| descricao | Simples | varchar | 255 | Descrição do item | Espada de fogo |

## Entidade: alimento
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_item  | Determinante  | uuid  | 35 | Número de identificador do item | 6465 |
| nome | Simples | int | 6 | Nome do item | espada |
| preco_de_venda  | simples  | int  | 6 | Valor da venda | 6465 |
| descricao | Simples | varchar | 255 | Descrição do item | Espada de fogo |
| nivel | simples  | int | 6 | Experiência que o alimento vai dar ao ser consumido | 10000 |
| cura | Simples | int | 3 | Quantidade de pontos de vida em que o digimon recupera ao consumir o alimento | 100 |

## Entidade: chave
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_item  | Determinante  | uuid  | 35 | Número de identificador do item | 6465 |
| nome | Simples | int | 6 | Nome do item | espada |
| preco_de_venda  | simples  | int  | 6 | Valor da venda | 6465 |
| descricao | Simples | varchar | 255 | Descrição do item | Espada de fogo |
| tipo | Simples | varchar | 20 | Tipo da chave | chave de sala do boss |

## Entidade: equipamento
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_item  | Determinante  | uuid  | 35 | Número de identificador do item | 6465 |
| nome | Simples | int | 6 | Nome do item | espada |
| preco_de_venda  | simples  | int  | 6 | Valor da venda | 6465 |
| descricao | Simples | varchar | 255 | Descrição do item | Espada de fogo |
| ataque_extra  | simples  | int  | 3 | Ataque extra que o equipamento | 120 |
| defesa_extra  | simples  | int  | 3 | Defesa extra que o equipamento | 130 |
| vida_extra  | simples  | int  | 3 | Vida extra que o equipamento | 140 |
| velocidade_extra  | simples  | int  | 3 | Velocidade extra que o equipamento | 150 |

## Entidade: instancia_item
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_instancia_item  | Determinante  | uuid  | 35 | Número de identificador da instância do item | 6465 |
| quantidade | Simples | int | 3 | Quantidade do item | 2 |

## Entidade: digivice
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_digivice  | Determinante  | uuid  | 35 | Número de identificador do digivice | 6465 |

## Entidade: instancia_digimon
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_instancia_digimon  | Determinante  | uuid  | 35 | Número de identificador da instância do digimon | 8685 |
| nivel | Simples | int | 2 | Nível do digimon | 23 |
| vida | Simples | int | 3 | Vida do digimon | 100 |
| ataque | Simples | int | 3 | Quantidade do ataque | 30 |
| velocidade | Simples | int | 3 | Quantidade da velocidade | 200 |
| vida_atual | Simples | int | 3 | Quantidade de vida que o digimon tem atualmente | 30 |
| defesa | Simples | int | 3 | Quantidade de defesa que o digimon tem | 25 |

## Entidade: batalha
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_batalha  | Determinante  | uuid  | 35 | Número de identificador da batalha | 8685 |


## Entidade: monstro
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_monstro  | Determinante  | uuid  | 35 | Número de identificador do monstro | 8685 |
| nivel | Simples | int | 2 | Nível do monstro | 23 |
| vida | Simples | int | 3 | Vida do monstro | 100 |
| ataque | Simples | int | 3 | Quantidade do ataque do monstro | 30 |
| velocidade | Simples | int | 3 | Quantidade da velocidade do monstro | 200 |
| vida_atual | Simples | int | 3 | Quantidade de vida que o monstro tem atualmente | 30 |
| defesa | Simples | int | 3 | Quantidade de defesa que o monstro tem | 25 |

## Entidade: chefe
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_monstro  | Determinante  | uuid  | 35 | Número de identificador do monstro | 8685 |
| nivel | Simples | int | 2 | Nível do monstro | 23 |
| vida | Simples | int | 3 | Vida do monstro | 100 |
| ataque | Simples | int | 3 | Quantidade do ataque do monstro | 30 |
| velocidade | Simples | int | 3 | Quantidade da velocidade do monstro | 200 |
| vida_atual | Simples | int | 3 | Quantidade de vida que o monstro tem atualmente | 30 |
| defesa | Simples | int | 3 | Quantidade de defesa que o monstro tem | 25 |
| ataque_extra  | simples  | int  | 3 | Ataque extra que o equipamento do chefe | 121 |
| defesa_extra  | simples  | int  | 3 | Defesa extra que o equipamento do chefe | 134 |
| vida_extra  | simples  | int  | 3 | Vida extra que o equipamento do chefe | 146 |
| velocidade_extra  | simples  | int  | 3 | Velocidade extra que o equipamento do chefe | 156 |

## Entidade: digimon
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_digimon  | Determinante  | uuid  | 35 | Número de identificador do digimon | 8685 |
| nome | Simples | varchar | 20 | Nome do digimon | Agumon |
| defesa_por_nivel | Simples | int | 3 | Quantidade de defesa que o digimon ganha ao subir de nível | 200 |
| vida_por_nivel | Simples | int | 3 | Quantidade de vida que o digimon ganha ao subir de nível | 30 |
| ataque_por_nivel | Simples | int | 3 | Quantidade de ataque que o digimon ganha ao subir de nível | 10 |
| valocidade_por_nivel | Simples | int | 3 | Quantidade de velocidade de ataque que o digimon ganha ao subir de nível | 25 |


## Entidade: categoria_digimon
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_categoria  | Determinante  | uuid  | 35 | Número de identificador da categoria | 8685 |


## Entidade: anjo
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_categoria  | Determinante  | uuid  | 35 | Número de identificador da categoria | 8685 |
| defesa_extra  | simples  | int  | 3 | Defesa extra que essa categoria da | 150 |


## Entidade: ghost
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_categoria  | Determinante  | uuid  | 35 | Número de identificador da categoria | 8685 |
| ataque_extra  | simples  | int  | 3 | ataque extra que essa categoria da | 150 |

## Entidade: monge
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_categoria  | Determinante  | uuid  | 35 | Número de identificador da categoria | 8685 |
| vida_extra  | simples  | int  | 3 | vida extra que essa categoria da | 150 |

## Entidade: ciborg
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_categoria  | Determinante  | uuid  | 35 | Número de identificador da categoria | 8685 |
| velocidade_extra  | simples  | int  | 3 | velocidade extra que essa categoria da | 150 |

## Entidade: dragao 
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_categoria  | Determinante  | uuid  | 35 | Número de identificador da categoria | 8685 |
| defesa_extra  | simples  | int  | 3 | Defesa extra que essa categoria da | 150 |
| ataque_extra  | simples  | int  | 3 | ataque extra que essa categoria da | 150 |
| vida_extra  | simples  | int  | 3 | vida extra que essa categoria da | 150 |
| velocidade_extra  | simples  | int  | 3 | velocidade extra que essa categoria da | 150 |

## Entidade: habilidade
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_habilidade  | Determinante  | uuid  | 35 | Número de identificador da habilidade | 8685 |
| nome | simples  | varchar | 20 | Nome da habilidade | ataque de fogo |
| descricao | Simples | varchar | 255 | Descrição da habilidade | Ataque de fogo tira 20 de dano |

## Entidade: ataque
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_habilidade  | Determinante  | uuid  | 35 | Número de identificador da habilidade | 8685 |
| nome | simples  | varchar | 20 | Nome da habilidade | ataque de fogo |
| descricao | Simples | varchar | 255 | Descrição da habilidade | Ataque de fogo tira 20 de dano |
| dano | Simples | int | 3 | Quantidade de dano da habilidade | 20 |

## Entidade: defesa
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id_habilidade  | Determinante  | uuid  | 35 | Número de identificador da habilidade | 8685 |
| nome | simples  | varchar | 20 | Nome da habilidade | Defesa angelical |
| descricao | Simples | varchar | 255 | Descrição da habilidade | Cria um escudo que diminui 10% do dano |
| defesa | Simples | int | 3 | Quantidade de defesa da habilidade | 30 |
