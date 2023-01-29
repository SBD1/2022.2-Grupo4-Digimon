
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE "mapa" (
    "id_mapa" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "altura" INTEGER NOT NULL,
    "largura" INTEGER NOT NULL,
    "descricao" varchar(255) NOT NULL,

    CONSTRAINT "mapa_pkey" PRIMARY KEY ("id_mapa")
);

CREATE TABLE "regiao" (
    "id_regiao" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" varchar(20) NOT NULL,
    "eixo_x" INTEGER NOT NULL,
    "eixo_y" INTEGER NOT NULL,
    "id_mapa" UUID NOT NULL,

    CONSTRAINT "regiao_pkey" PRIMARY KEY ("id_regiao"),
    CONSTRAINT "regiao_mapa_fkey" FOREIGN KEY ("id_mapa") REFERENCES "mapa"("id_mapa")
);

CREATE TABLE "regiao_regiao" (
    "id_regiao1" UUID NOT NULL,
    "id_regiao2" UUID NOT NULL,

    CONSTRAINT "regiao_regiao_pkey" PRIMARY KEY ("id_regiao1", "id_regiao2"),
    CONSTRAINT "regiao_regiao_regiao1_fkey" FOREIGN KEY ("id_regiao1") REFERENCES "regiao"("id_regiao"),
    CONSTRAINT "regiao_regiao_regiao2_fkey" FOREIGN KEY ("id_regiao2") REFERENCES "regiao"("id_regiao")
);

CREATE TYPE tipos_categoria_jogador AS ENUM ('Duelista', 'Suporte', 'Conservador');

CREATE TABLE "categoria_jogador" (
    "id_categoria_jogador" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "historia" varchar(255) NOT NULL,
    "tipo" tipos_categoria_jogador NOT NULL,

    CONSTRAINT "categoria_jogador_pkey" PRIMARY KEY ("id_categoria_jogador")
);

CREATE TABLE "jogador" (
    "id_jogador" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" varchar(20) UNIQUE NOT NULL,
    "vitorias" integer DEFAULT 0,
  "derrotas" integer DEFAULT 0,
  "dinheiro" integer DEFAULT 0,
  "id_categoria_jogador" UUID NOT NULL,
  "id_regiao" UUID NOT NULL,
  
    CONSTRAINT "jogador_pkey" PRIMARY KEY ("id_jogador"),
    CONSTRAINT "jogador_nome_ukey" UNIQUE KEY ("nome"),
  	CONSTRAINT "jogador_regiao_fkey" FOREIGN KEY ("id_regiao") REFERENCES "regiao"("id_regiao"),
    CONSTRAINT "jogador_categoria_jogador_fkey" FOREIGN KEY ("id_categoria_jogador") REFERENCES "categoria_jogador"("id_categoria_jogador")
);

CREATE TABLE "digivice" (
    "id_digivice" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "id_jogador" UUID NOT NULL,
  
    CONSTRAINT "digivice_pkey" PRIMARY KEY ("id_digivice"),
  	CONSTRAINT "digivice_jogador_fkey" FOREIGN KEY ("id_jogador") REFERENCES "jogador"("id_jogador")
);


CREATE TABLE "categoria_digimon" (
    "id_categoria_digimon" UUID NOT NULL DEFAULT uuid_generate_v4(),
  
    CONSTRAINT "categoria_digimon_pkey" PRIMARY KEY ("id_categoria_digimon")
);

CREATE TABLE "anjo" (
    "defesa_extra" integer DEFAULT 0,
	 "id_categoria_digimon" UUID NOT NULL,
    
    CONSTRAINT "anjo_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon")
);

CREATE TABLE "fantasma" (
    "ataque_extra" integer DEFAULT 0,
	"id_categoria_digimon" UUID NOT NULL,
    
    CONSTRAINT "fantasma_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon")
);

CREATE TABLE "monge" (
    "vida_extra" integer DEFAULT 0,
   "id_categoria_digimon" UUID NOT NULL,

	CONSTRAINT "monge_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon")
);

CREATE TABLE "ciborg" (
    "velocidade_extra" integer DEFAULT 0,
    "id_categoria_digimon" UUID NOT NULL,
    
    CONSTRAINT "ciborg_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon")
);

CREATE TABLE "dragao" (
    "defesa_extra" integer DEFAULT 0,
  "ataque_extra" integer DEFAULT 0,
  "vida_extra" integer DEFAULT 0,
    "velocidade_extra" integer DEFAULT 0,
    "id_categoria_digimon" UUID NOT NULL,
    
    CONSTRAINT "dragao_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon")
);

CREATE TABLE "habilidade" (
    "id_habilidade" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" varchar(20) NOT NULL,
    "descricao" varchar(255) NOT NULL,
  
    CONSTRAINT "habilidade_pkey" PRIMARY KEY ("id_habilidade")
);

CREATE TABLE "ataque" (
    "dano" integer DEFAULT 0,
     "id_habilidade" UUID NOT NULL,
     
     CONSTRAINT "ataque_habilidade_fkey" FOREIGN KEY ("id_habilidade") REFERENCES "habilidade"("id_habilidade")
);

CREATE TABLE "defesa" (
    "defesa" integer DEFAULT 0,
    "id_habilidade" UUID NOT NULL,
    
    CONSTRAINT "defesa_habilidade_fkey" FOREIGN KEY ("id_habilidade") REFERENCES "habilidade"("id_habilidade")
);

CREATE TABLE "digimon" (
    "id_digimon" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "nome" varchar(20) NOT NULL,
  "ataque_por_nivel" integer DEFAULT 0,
  "defesa_por_nivel" integer DEFAULT 0,
  "vida_por_nivel" integer DEFAULT 0,
  "velocidade_por_nivel" integer DEFAULT 0,
  "id_categoria_digimon" UUID NOT NULL,
  
    CONSTRAINT "digimon_pkey" PRIMARY KEY ("id_digimon"),
  CONSTRAINT "digimon_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon")
);

CREATE TABLE "digimon_habilidade" (
    "id_digimon" UUID NOT NULL,
    "id_habilidade" UUID NOT NULL,

CONSTRAINT "digimon_habilidade_pkey" PRIMARY KEY ("id_digimon", "id_habilidade"),
    CONSTRAINT "digimon_habilidade_digimon_fkey" FOREIGN KEY ("id_digimon") REFERENCES "digimon"("id_digimon"),
    CONSTRAINT "digimon_habilidade_habilidade_fkey" FOREIGN KEY ("id_habilidade") REFERENCES "habilidade"("id_habilidade")
);

CREATE TABLE "item" (
    "id_item" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "nome" varchar(20) NOT NULL,
  "preco_de_venda" integer DEFAULT 0,
  "descricao" varchar(255) NOT NULL,
  
    CONSTRAINT "item_pkey" PRIMARY KEY ("id_item")
);

CREATE TABLE "alimento" (
  "experiencia" integer DEFAULT 0,
  "cura" integer DEFAULT 0,
  "id_item" UUID NOT NULL,
  
  CONSTRAINT "alimento_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item")
);

CREATE TYPE tipos_item_chave AS ENUM ('A', 'B');

CREATE TABLE "chave" (
  "tipo" tipos_item_chave NOT NULL,
  "id_item" UUID NOT NULL,
  
  CONSTRAINT "chave_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item")
);

CREATE TABLE "equipamento" (
  "defesa_extra" integer DEFAULT 0,
  "ataque_extra" integer DEFAULT 0,
  "vida_extra" integer DEFAULT 0,
    "velocidade_extra" integer DEFAULT 0,
    "id_item" UUID NOT NULL,
    
    CONSTRAINT "equipamento_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item")
);

CREATE TABLE "instancia_item" (
    "id_instancia_item" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "quantidade" integer DEFAULT 1,
  "id_item" UUID NOT NULL,
  "id_digivice" UUID NOT NULL,
  
    CONSTRAINT "instancia_item_pkey" PRIMARY KEY ("id_instancia_item"),
    CONSTRAINT "instancia_item_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item"),
    CONSTRAINT "instancia_item_digivice_fkey" FOREIGN KEY ("id_digivice") REFERENCES "digivice"("id_digivice")

);

CREATE TABLE "instancia_digimon" (
    "id_instancia_digimon" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "vida_atual" integer NOT NULL,
  "nivel" integer DEFAULT 1,
  "id_digimon" UUID NOT NULL,
  "id_digivice" UUID NOT NULL,
  
    CONSTRAINT "instancia_digimon_pkey" PRIMARY KEY ("id_instancia_digimon"),
    CONSTRAINT "instancia_digimon_digimon_fkey" FOREIGN KEY ("id_digimon") REFERENCES "digimon"("id_digimon"),
    CONSTRAINT "instancia_digimon_digivice_fkey" FOREIGN KEY ("id_digivice") REFERENCES "digivice"("id_digivice")
);

CREATE TABLE "batalha" (
    "id_batalha" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "id_instancia_digimon" UUID NOT NULL,
  
    CONSTRAINT "batalha_pkey" PRIMARY KEY ("id_batalha"),
    CONSTRAINT "batalha_instancia_digimon_fkey" FOREIGN KEY ("id_instancia_digimon") REFERENCES "instancia_digimon"("id_instancia_digimon")
);

CREATE TABLE "monstro" (
    "id_monstro" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nivel" integer DEFAULT 1,
    "vida_atual" integer NOT NULL,
  "id_digimon" UUID NOT NULL,
  "id_batalha" UUID NOT NULL,

    CONSTRAINT "monstro_pkey" PRIMARY KEY ("id_monstro"),
    CONSTRAINT "monstro_digimon_fkey" FOREIGN KEY ("id_digimon") REFERENCES "digimon"("id_digimon"),
    CONSTRAINT "monstro_batalha_fkey" FOREIGN KEY ("id_batalha") REFERENCES "batalha"("id_batalha")
);

CREATE TABLE "chefe" (
  "defesa_extra" integer DEFAULT 0,
  "ataque_extra" integer DEFAULT 0,
  "vida_extra" integer DEFAULT 0,
    "velocidade_extra" integer DEFAULT 0,
    "id_monstro" UUID NOT NULL,
    
    CONSTRAINT "chefe_monstro_fkey" FOREIGN KEY ("id_monstro") REFERENCES "monstro"("id_monstro")
);

CREATE TABLE "item_batalha" (
    "id_item" UUID NOT NULL,
    "id_batalha" UUID NOT NULL,

    CONSTRAINT "item_batalha_pkey" PRIMARY KEY ("id_batalha", "id_item"),
    CONSTRAINT "item_batalha_batalha_fkey" FOREIGN KEY ("id_batalha") REFERENCES "batalha"("id_batalha"),
    CONSTRAINT "item_batalha_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item")
);









CREATE TABLE "instancia_digimon_instancia_item" (
    "id_instancia_digimon" UUID NOT NULL,
    "id_instancia_item" UUID NOT NULL,

    CONSTRAINT "instancia_digimon_instancia_item_pkey" PRIMARY KEY ("id_instancia_item", "id_instancia_digimon"),
    CONSTRAINT "instancia_digimon_instancia_item_instancia_digimon_fkey" FOREIGN KEY ("id_instancia_digimon") REFERENCES "instancia_digimon"("id_instancia_digimon"),
    CONSTRAINT "instancia_digimon_instancia_item_instancia_item_fkey" FOREIGN KEY ("id_instancia_item") REFERENCES "instancia_item"("id_instancia_item")
);


CREATE TABLE "npc" (
    "id_npc" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" varchar(20) NOT NULL,
  "id_regiao" UUID NOT NULL,

    CONSTRAINT "npc_pkey" PRIMARY KEY ("id_npc"),
    CONSTRAINT "npc_regiao_fkey" FOREIGN KEY ("id_regiao") REFERENCES "regiao"("id_regiao")
);

CREATE TABLE "habitante" (
	"id_npc" UUID NOT NULL,
	
	CONSTRAINT "habitante_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc")
);

CREATE TABLE "curandeiro" (
	"id_npc" UUID NOT NULL,

	CONSTRAINT "curandeiro_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc")
);

CREATE TABLE "guia" (
  "id_npc" UUID NOT NULL,
  
  CONSTRAINT "guia_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc")
);

create type "tipo_mercador" as ENUM ('comerciante de armas', 'vendedor de frutas');

CREATE TABLE "mercador" (
  "tipo" tipo_mercador not null,
  "id_npc" UUID NOT NULL,
  
  CONSTRAINT "mercador_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc")
);

CREATE TABLE "missao" (
    "id_missao" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" varchar(20) NOT NULL,
    "experiencia" integer DEFAULT 0,
  	"id_npc" UUID NOT NULL,

    CONSTRAINT "missao_pkey" PRIMARY KEY ("id_missao"),
    CONSTRAINT "missao_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc")
);

CREATE TABLE "missao_jogador" (
    "id_missao" UUID NOT NULL,
    "id_jogador" UUID NOT NULL,
    "concluida" BOOL NOT NULL,

    CONSTRAINT "missao_jogador_pkey" PRIMARY KEY ("id_missao", "id_jogador"),
     CONSTRAINT "missao_jogador_jogador_fkey" FOREIGN KEY ("id_jogador") REFERENCES "jogador"("id_jogador"),
    CONSTRAINT "missao_jogador_missao_fkey" FOREIGN KEY ("id_missao") REFERENCES "missao"("id_missao")
);


CREATE TABLE "dialogo" (
    "id_dialogo" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "texto" varchar(255) NOT NULL,
    "id_missao" UUID,
    "id_jogador" UUID,
    "id_npc" UUID,

    CONSTRAINT "dialogo_pkey" PRIMARY KEY ("id_dialogo"),
    CONSTRAINT "dialogo_missao_fkey" FOREIGN KEY ("id_missao") REFERENCES "missao"("id_missao"),
    CONSTRAINT "dialogo_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc"),
    CONSTRAINT "dialogo_jogador_fkey" FOREIGN KEY ("id_jogador") REFERENCES "jogador"("id_jogador")
);

CREATE TABLE "mercador_item" (
    "id_npc" UUID NOT NULL,
    "id_item" UUID NOT NULL,
    "preco" integer DEFAULT 0,

    CONSTRAINT "mercador_item_pkey" PRIMARY KEY ("id_mercador", "id_item"),
     CONSTRAINT "mercador_item_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc"),
    CONSTRAINT "mercador_item_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item")
);

















