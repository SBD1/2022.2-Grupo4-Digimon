CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE "mapa" (
    "id_mapa" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "altura" INTEGER NOT NULL,
    "largura" INTEGER NOT NULL,
    "descricao" TEXT NOT NULL,

    CONSTRAINT "mapa_pkey" PRIMARY KEY ("id_mapa")
);

CREATE TABLE "regiao" (
    "id_regiao" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" TEXT NOT NULL,
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
    "historia" TEXT NOT NULL,
    "tipo" tipos_categoria_jogador NOT NULL,

    CONSTRAINT "categoria_jogador_pkey" PRIMARY KEY ("id_categoria_jogador")
);

CREATE TABLE "jogador" (
    "id_jogador" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" TEXT NOT NULL,
    "vitorias" integer DEFAULT 0,
  "derrotas" integer DEFAULT 0,
  "dinheiro" integer DEFAULT 0,
  "id_categoria_jogador" UUID NOT NULL,
  "id_regiao" UUID NOT NULL,
  
    CONSTRAINT "jogador_pkey" PRIMARY KEY ("id_jogador"),
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

CREATE TABLE "categoria_digimon_anjo" (
    "defesa_extra" integer NOT NULL
) INHERITS (categoria_digimon);

CREATE TABLE "categoria_digimon_fantasma" (
    "ataque_extra" integer NOT NULL
) INHERITS (categoria_digimon);

CREATE TABLE "categoria_digimon_monge" (
    "vida_extra" integer NOT NULL
) INHERITS (categoria_digimon);

CREATE TABLE "categoria_digimon_ciborg" (
    "velocidade_extra" integer NOT NULL
) INHERITS (categoria_digimon);

CREATE TABLE "categoria_digimon_dragao" (
    "defesa_extra" integer NOT NULL,
  "ataque_extra" integer NOT NULL,
  "vida_extra" integer NOT NULL,
    "velocidade_extra" integer NOT NULL
) INHERITS (categoria_digimon);

CREATE TABLE "habilidade" (
    "id_habilidade" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
  
    CONSTRAINT "habilidade_pkey" PRIMARY KEY ("id_habilidade")
);

CREATE TABLE "habilidade_ataque" (
    "dano" integer NOT NULL
) INHERITS (habilidade);

CREATE TABLE "habilidade_defesa" (
    "defesa" integer NOT NULL
) INHERITS (habilidade);

CREATE TABLE "digimon" (
    "id_digimon" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "nome" TEXT NOT NULL,
  "ataque_por_nivel" integer NOT NULL,
  "defesa_por_nivel" integer NOT NULL,
  "vida_por_nivel" integer NOT NULL,
  "velocidade_por_nivel" integer NOT NULL,
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
  "nome" TEXT NOT NULL,
  "preco_de_venda" integer NOT NULL,
  "descricao" TEXT NOT NULL,
  
    CONSTRAINT "item_pkey" PRIMARY KEY ("id_item")
);

CREATE TABLE "item_alimento" (
  "experiencia" integer NOT NULL,
  "cura" integer NOT NULL
) INHERITS (item);

CREATE TYPE tipos_item_chave AS ENUM ('A', 'B');

CREATE TABLE "item_chave" (
  "tipo" tipos_item_chave NOT NULL
) INHERITS (item);

CREATE TABLE "item_equipamento" (
  "defesa_extra" integer NOT NULL,
  "ataque_extra" integer NOT NULL,
  "vida_extra" integer NOT NULL,
    "velocidade_extra" integer NOT NULL
) INHERITS (item);

CREATE TABLE "instancia_item" (
    "id_instancia_item" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "quantidade" integer NOT NULL,
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

CREATE TABLE "capanga" () INHERITS (monstro);

CREATE TABLE "chefe" (
  "defesa_extra" integer NOT NULL,
  "ataque_extra" integer NOT NULL,
  "vida_extra" integer NOT NULL,
    "velocidade_extra" integer NOT NULL
) INHERITS (monstro);

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
    "nome" TEXT NOT NULL,
  "id_regiao" UUID NOT NULL,

    CONSTRAINT "npc_pkey" PRIMARY KEY ("id_npc"),
    CONSTRAINT "npc_regiao_fkey" FOREIGN KEY ("id_regiao") REFERENCES "regiao"("id_regiao")
);

CREATE TABLE "npc_habitante" () INHERITS (npc);

CREATE TABLE "npc_curandeiro" () INHERITS (npc);

CREATE TABLE "npc_guia" (
  "id_npc_guia" UUID NOT NULL DEFAULT uuid_generate_v4(),
  
  CONSTRAINT "npc_guia_pkey" PRIMARY KEY ("id_npc_guia")
) INHERITS (npc);

create type "tipo_mercador" as ENUM ('comerciante de armas', 'vendedor de frutas');

CREATE TABLE "npc_mercador" (
  "id_npc_mercador" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "tipo" tipo_mercador not null,
  
  CONSTRAINT "npc_mercador_pkey" PRIMARY KEY ("id_npc_mercador")
) INHERITS (npc);

CREATE TABLE "missao" (
    "id_missao" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" TEXT NOT NULL,
    "experiencia" INTEGER NOT NULL,
  	"id_npc_guia" UUID NOT NULL,

    CONSTRAINT "missao_pkey" PRIMARY KEY ("id_missao"),
    CONSTRAINT "missao_npc_guia_fkey" FOREIGN KEY ("id_npc_guia") REFERENCES "npc_guia"("id_npc_guia")
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
    "texto" TEXT NOT NULL,
    "id_missao" UUID,
    "id_jogador" UUID,

    CONSTRAINT "dialogo_pkey" PRIMARY KEY ("id_dialogo"),
    CONSTRAINT "dialogo_missao_fkey" FOREIGN KEY ("id_missao") REFERENCES "missao"("id_missao"),
    CONSTRAINT "dialogo_jogador_fkey" FOREIGN KEY ("id_jogador") REFERENCES "jogador"("id_jogador")
);

CREATE TABLE "mercador_item" (
    "id_npc_mercador" UUID NOT NULL,
    "id_item" UUID NOT NULL,
    "preco" INTEGER NOT NULL,

    CONSTRAINT "mercador_item_pkey" PRIMARY KEY ("id_npc_mercador", "id_item"),
     CONSTRAINT "mercador_item_mercador_fkey" FOREIGN KEY ("id_npc_mercador") REFERENCES "npc_mercador"("id_npc_mercador"),
    CONSTRAINT "mercador_item_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item")
);