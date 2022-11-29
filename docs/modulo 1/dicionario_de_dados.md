# Dicionário de Dados

## Entidade: jogador
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id  | Determinante  | int  | 4 | Número de identificação do jogador | 0001 |
| nome  | Simples  | varchar  | 20 | Apelido do jogador | Pedro21 |
| idade  | Simples  | int  | 2 | Idade do jogador | 22 |
| historia  | Simples  | varchar  | 20 | História do jogador | Meu nome é pedro e gosto muito de digimon. |
| vitorias_digimon  | Simples  | int  | 4 | Vitória contra monstros digimon | 1234 |
| vitorias_jogadores  | Simples  | int  | 4 | Vitórias contra outro jogador | 4321 |
| total_partidas  | Simples  | int  | 6 | Total de partidas jogadas pelo jogador | 100000 |

## Entidade: batalha
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id  | Determinante  | int  | 4 | Número de identificação do jogador | 0001 |
| turno  | Simples  | varchar  | 10 | Seu turno ou do adversário | Seu ou adversário |
| resultado | Simples | char | 1 | Vitória ou derrota | V ou F |
| id_vencedor | Simples | int | 4 | Número de identificação do jogador vencedor | 0001 |

## Entidade: acao
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id  | Determinante  | int  | 4 | Número de identificação da ação | 0014 |
| ordem | Simples | varchar | 100 | Ordem do jogador | Atacar adversário |
| realizada | Simples | varchar | 20 | Ordem realizada ou não | realizada ou não realizada |

## Entidade: posicao
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id  | Determinante  | int  | 4 | Número de identificador da posição | 0023 |
| eixo_x | Simples | int | 3 | Coordenada do objeto no eixo x | 100 |
| eixo_y | Simples | int | 3 | Coordenada do objeto no eixo y | 000 |

## Entidade: digimonBatalha
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id  | Determinante  | int  | 4 | Número de identificador do digimon em batalha | 9013 |
| vida_batalha | Simples | int | 3 | Número de vidas em que o digimon tem na batalha | 22 |

## Entidade: instancia_digimon
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id  | Determinante  | int  | 4 | Número de identificador da instância do digimon | 5345 |
| xp | Simples | int | 4 | Experiência adquirida após um batalha | 1500 |
| nivel | Simples | int | 2 | Nível do digimon | 48 |
| ataque | Simples | varchar | 20 | Habilidade de ataque do digimon | Golpe no adversário |
| vida | Simples | int | 3 | Vida base do digimon | 100 |
| velocidade | Simples | int | 3 | Velocidade de ataque do digimon | 300 |

## Entidade: ataque
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id  | Determinante  | int  | 4 | Número de identificador do ataque | 6465 |
| nome | Simples | varchar | 20 | Nome do ataque | Golpe de fogo |
| dano | Simples | int | 3 | Quantidade de dano do ataque | 40 |
| casas | Simples | int | 2 | Número da casa onde o digimon está | 7 |
| direcao | Simples | varchar | 20 | Para qual digimon vai ser o ataque | horizontal |

## Entidade: digimon_base
| Atributos  |  Classe | Tipo | Tamanho | Descrição | Exemplo |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| id  | Determinante  | int  | 4 | Número de identificador do digimon base | 8685 |
| nome | Simples | varchar | 20 | Nome do digimon | Agumon |
| vida_base | Simples | int | 3 | Vida base do digimon | 100 |
| ataque_base | Simples | int | 3 | Quantidade do ataque base | 30 |
| velocidade_base | Simples | int | 3 | Quantidade da velocidade base | 200 |
| historia | Simples | varchar | 2000 | Descrição da história do digimon | Um monstro com aparência reptiliana, que parece um pequeno dinossauro |
| vida_por_nivel | Simples | int | 3 | Quantidade de vida que o digimon ganha ao subir de nível | 30 |
| ataque_por_nivel | Simples | int | 3 | Quantidade de ataque que o digimon ganha ao subir de nível | 10 |
| valocidade_por_nivel | Simples | int | 3 | Quantidade de velocidade de ataque que o digimon ganha ao subir de nível | 25 |
