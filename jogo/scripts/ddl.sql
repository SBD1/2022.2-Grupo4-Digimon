
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE "mapa" (
    "id_mapa" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "altura" INTEGER NOT NULL,
    "largura" INTEGER NOT NULL,
    "descricao" varchar(255) NOT NULL

);

alter table mapa add CONSTRAINT "mapa_pkey" PRIMARY KEY ("id_mapa");

CREATE TABLE "regiao" (
    "id_regiao" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" varchar(20) NOT NULL,
    "eixo_x" INTEGER NOT NULL,
    "eixo_y" INTEGER NOT NULL,
    "id_mapa" UUID NOT NULL
);


alter table regiao add CONSTRAINT "regiao_pkey" PRIMARY KEY ("id_regiao");
alter table regiao add CONSTRAINT "regiao_mapa_fkey" FOREIGN KEY ("id_mapa") REFERENCES "mapa"("id_mapa");

CREATE TABLE "regiao_regiao" (
    "id_regiao1" UUID NOT NULL,
    "id_regiao2" UUID NOT NULL
);

alter table regiao_regiao add CONSTRAINT "regiao_regiao_pkey" PRIMARY KEY ("id_regiao1", "id_regiao2");
alter table regiao_regiao add CONSTRAINT "regiao_regiao_regiao1_fkey" FOREIGN KEY ("id_regiao1") REFERENCES "regiao"("id_regiao");
alter table regiao_regiao add CONSTRAINT "regiao_regiao_regiao2_fkey" FOREIGN KEY ("id_regiao2") REFERENCES "regiao"("id_regiao");

CREATE TYPE tipos_categoria_jogador AS ENUM ('Duelista', 'Suporte', 'Conservador');

CREATE TABLE "categoria_jogador" (
    "id_categoria_jogador" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "historia" varchar(255) NOT NULL,
    "tipo" tipos_categoria_jogador unique NOT NULL
);

alter table categoria_jogador add CONSTRAINT "categoria_jogador_tipo_ukey" UNIQUE ("tipo");
alter table categoria_jogador add CONSTRAINT "categoria_jogador_pkey" PRIMARY KEY ("id_categoria_jogador")

CREATE TABLE "jogador" (
    "id_jogador" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" varchar(20) UNIQUE NOT NULL,
    "vitorias" integer DEFAULT 0,
  "derrotas" integer DEFAULT 0,
  "dinheiro" integer DEFAULT 0,
  "id_categoria_jogador" UUID NOT NULL,
  "id_regiao" UUID NOT NULL
);

alter table jogador add CONSTRAINT "jogador_pkey" PRIMARY KEY ("id_jogador");
alter table jogador add CONSTRAINT "jogador_nome_ukey" UNIQUE ("nome");
alter table jogador add CONSTRAINT "jogador_regiao_fkey" FOREIGN KEY ("id_regiao") REFERENCES "regiao"("id_regiao");
alter table jogador add CONSTRAINT "jogador_categoria_jogador_fkey" FOREIGN KEY ("id_categoria_jogador") REFERENCES "categoria_jogador"("id_categoria_jogador");


CREATE TABLE "digivice" (
    "id_digivice" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "id_jogador" UUID NOT NULL
);

alter table digivice add CONSTRAINT "digivice_pkey" PRIMARY KEY ("id_digivice");
alter table digivice add CONSTRAINT "digivice_jogador_fkey" FOREIGN KEY ("id_jogador") REFERENCES "jogador"("id_jogador");

create TYPE tipos_categoria_digimon AS ENUM ('anjo', 'fantasma', 'monge', 'ciborg', 'dragao');

CREATE TABLE "categoria_digimon" (
    "id_categoria_digimon" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "tipo" tipos_categoria_digimon unique NOT NULL
);

alter table categoria_digimon add CONSTRAINT "categoria_digimon_tipo_ukey" UNIQUE ("tipo");
alter table categoria_digimon add CONSTRAINT "categoria_digimon_pkey" PRIMARY KEY ("id_categoria_digimon");

CREATE TABLE "anjo" (
    "defesa_extra" integer DEFAULT 0,
	 "id_categoria_digimon" UUID NOT NULL
);

alter table anjo add CONSTRAINT "anjo_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon");

CREATE TABLE "fantasma" (
    "ataque_extra" integer DEFAULT 0,
	"id_categoria_digimon" UUID NOT NULL
);

alter table fantasma add CONSTRAINT "fantasma_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon");

CREATE TABLE "monge" (
    "vida_extra" integer DEFAULT 0,
   "id_categoria_digimon" UUID NOT NULL
);

alter table monge add CONSTRAINT "monge_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon");

CREATE TABLE "ciborg" (
    "velocidade_extra" integer DEFAULT 0,
    "id_categoria_digimon" UUID NOT NULL
);

alter table ciborg add CONSTRAINT "ciborg_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon");

CREATE TABLE "dragao" (
    "defesa_extra" integer DEFAULT 0,
  "ataque_extra" integer DEFAULT 0,
  "vida_extra" integer DEFAULT 0,
    "velocidade_extra" integer DEFAULT 0,
    "id_categoria_digimon" UUID NOT NULL
);

alter table dragao add CONSTRAINT "dragao_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon");

CREATE TYPE tipos_habilidade AS ENUM ('ataque', 'defesa');

CREATE TABLE "habilidade" (
    "id_habilidade" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" varchar(20) NOT NULL,
    "descricao" varchar(255) NOT NULL,
    "tipo" tipos_habilidade NOT NULL
);

alter table habilidade add CONSTRAINT "habilidade_pkey" PRIMARY KEY ("id_habilidade");

CREATE TABLE "ataque" (
    "dano" integer DEFAULT 0,
     "id_habilidade" UUID NOT NULL
);

alter table ataque add CONSTRAINT "ataque_habilidade_fkey" FOREIGN KEY ("id_habilidade") REFERENCES "habilidade"("id_habilidade");

CREATE TABLE "defesa" (
    "defesa" integer DEFAULT 0,
    "id_habilidade" UUID NOT NULL
);

alter table defesa add CONSTRAINT "defesa_habilidade_fkey" FOREIGN KEY ("id_habilidade") REFERENCES "habilidade"("id_habilidade");

CREATE TABLE "digimon" (
    "id_digimon" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "nome" varchar(20) unique NOT NULL,
  "ataque_por_nivel" integer DEFAULT 0,
  "defesa_por_nivel" integer DEFAULT 0,
  "vida_por_nivel" integer DEFAULT 0,
  "velocidade_por_nivel" integer DEFAULT 0,
  "id_categoria_digimon" UUID NOT NULL
);

alter table digimon add CONSTRAINT "digimon_nome_ukey" UNIQUE ("nome");
alter table digimon add CONSTRAINT "digimon_pkey" PRIMARY KEY ("id_digimon");
alter table digimon add CONSTRAINT "digimon_categoria_digimon_fkey" FOREIGN KEY ("id_categoria_digimon") REFERENCES "categoria_digimon"("id_categoria_digimon");

CREATE TABLE "digimon_habilidade" (
    "id_digimon" UUID NOT NULL,
    "id_habilidade" UUID NOT NULL
);

alter table digimon_habilidade add CONSTRAINT "digimon_habilidade_pkey" PRIMARY KEY ("id_digimon", "id_habilidade");
alter table digimon_habilidade add CONSTRAINT "digimon_habilidade_digimon_fkey" FOREIGN KEY ("id_digimon") REFERENCES "digimon"("id_digimon");
alter table digimon_habilidade add CONSTRAINT "digimon_habilidade_habilidade_fkey" FOREIGN KEY ("id_habilidade") REFERENCES "habilidade"("id_habilidade");

CREATE TYPE tipos_item AS ENUM ('alimento', 'chave', 'equipamento');

CREATE TABLE "item" (
    "id_item" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "nome" varchar(20) NOT NULL,
  "preco_de_venda" integer DEFAULT 0,
  "descricao" varchar(255) NOT NULL,
  "tipo" tipos_item NOT NULL
);

alter table item add CONSTRAINT "item_pkey" PRIMARY KEY ("id_item");

CREATE TABLE "alimento" (
  "nivel" integer DEFAULT 0,
  "cura" integer DEFAULT 0,
  "id_item" UUID NOT NULL
);

alter table alimento add CONSTRAINT "alimento_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item");


CREATE TYPE tipos_item_chave AS ENUM ('A', 'B');

CREATE TABLE "chave" (
  "tipo" tipos_item_chave NOT NULL,
  "id_item" UUID NOT NULL
  );

alter table chave add CONSTRAINT "chave_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item");

CREATE TABLE "equipamento" (
  "defesa_extra" integer DEFAULT 0,
  "ataque_extra" integer DEFAULT 0,
  "vida_extra" integer DEFAULT 0,
  "velocidade_extra" integer DEFAULT 0,
  "id_item" UUID NOT NULL
);

alter table equipamento add CONSTRAINT "equipamento_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item");


CREATE TABLE "instancia_item" (
    "id_instancia_item" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "quantidade" integer DEFAULT 1,
  "id_item" UUID NOT NULL,
  "id_digivice" UUID NOT NULL
);

alter table instancia_item add CONSTRAINT "instancia_item_pkey" PRIMARY KEY ("id_instancia_item");
alter table instancia_item add CONSTRAINT "instancia_item_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item");
alter table instancia_item add CONSTRAINT "instancia_item_digivice_fkey" FOREIGN KEY ("id_digivice") REFERENCES "digivice"("id_digivice");

CREATE TABLE "instancia_digimon" (
    "id_instancia_digimon" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "vida_atual" integer NOT NULL,
  "nivel" integer DEFAULT 1,
  "vida" integer NOT NULL,
  "defesa" integer NOT NULL,
  "ataque" integer NOT NULL,
  "velocidade" integer NOT NULL,
  "id_digimon" UUID NOT NULL,
  "id_digivice" UUID NOT NULL
);

alter table instancia_digimon add CONSTRAINT "instancia_digimon_pkey" PRIMARY KEY ("id_instancia_digimon");
alter table instancia_digimon add CONSTRAINT "instancia_digimon_digimon_fkey" FOREIGN KEY ("id_digimon") REFERENCES "digimon"("id_digimon");
alter table instancia_digimon add CONSTRAINT "instancia_digimon_digivice_fkey" FOREIGN KEY ("id_digivice") REFERENCES "digivice"("id_digivice");

CREATE TABLE "instancia_digimon_instancia_item" (
    "id_instancia_digimon" UUID NOT NULL,
    "id_instancia_item" UUID NOT NULL
);

alter table instancia_digimon_instancia_item add CONSTRAINT "instancia_digimon_instancia_item_pkey" PRIMARY KEY ("id_instancia_item", "id_instancia_digimon");
alter table instancia_digimon_instancia_item add CONSTRAINT "instancia_digimon_instancia_item_instancia_digimon_fkey" FOREIGN KEY ("id_instancia_digimon") REFERENCES "instancia_digimon"("id_instancia_digimon");
alter table instancia_digimon_instancia_item add CONSTRAINT "instancia_digimon_instancia_item_instancia_item_fkey" FOREIGN KEY ("id_instancia_item") REFERENCES "instancia_item"("id_instancia_item");

CREATE TYPE tipos_npc AS ENUM ('curandeiro', 'habitante', 'guia', 'mercador');

CREATE TABLE "npc" (
    "id_npc" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" varchar(20) unique NOT NULL,
  "id_regiao" UUID NOT NULL,
    "tipo" tipos_npc NOt NULL
);

alter table npc add CONSTRAINT "npc_nome_ukey" UNIQUE ("nome");
alter table npc add CONSTRAINT "npc_pkey" PRIMARY KEY ("id_npc");
alter table npc add CONSTRAINT "npc_regiao_fkey" FOREIGN KEY ("id_regiao") REFERENCES "regiao"("id_regiao");

CREATE TABLE "habitante" (
	"id_npc" UUID NOT NULL
);

alter table habitante add CONSTRAINT "habitante_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc");

CREATE TABLE "curandeiro" (
	"id_npc" UUID NOT NULL
);

alter table curandeiro add CONSTRAINT "curandeiro_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc");

CREATE TABLE "guia" (
  "id_npc" UUID NOT NULL
);

alter table guia add CONSTRAINT "guia_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc");

create type "tipo_mercador" as ENUM ('comerciante de armas', 'vendedor de frutas');

CREATE TABLE "mercador" (
  "tipo" tipo_mercador not null,
  "id_npc" UUID NOT NULL
);

alter table mercador add CONSTRAINT "mercador_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc");

CREATE TABLE "missao" (
    "id_missao" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nome" varchar(20) unique NOT NULL,
    "nivel" integer DEFAULT 0,
  	"id_npc" UUID NOT NULL
);

alter table missao add CONSTRAINT "missao_nome_ukey" UNIQUE ("nome");
alter table missao add CONSTRAINT "missao_pkey" PRIMARY KEY ("id_missao");
alter table missao add CONSTRAINT "missao_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc");

CREATE TABLE "batalha" (
  "id_batalha" UUID NOT NULL DEFAULT uuid_generate_v4(),
  "id_instancia_digimon" UUID NOT NULL,
  "id_missao" UUID NOT NULL
);

alter table batalha add CONSTRAINT "batalha_pkey" PRIMARY KEY ("id_batalha");
alter table batalha add CONSTRAINT "batalha_instancia_digimon_fkey" FOREIGN KEY ("id_instancia_digimon") REFERENCES "instancia_digimon"("id_instancia_digimon");
alter table batalha add CONSTRAINT "batalha_missao_fkey" FOREIGN KEY ("id_missao") REFERENCES "missao"("id_missao");


CREATE TABLE "monstro" (
    "id_monstro" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "nivel" integer DEFAULT 1,
    "vida_atual" integer NOT NULL,
    "vida" integer NOT NULL,
  "defesa" integer NOT NULL,
  "ataque" integer NOT NULL,
  "velocidade" integer NOT NULL,
  "id_digimon" UUID NOT NULL,
  "id_batalha" UUID NOT NULL
);

alter table monstro add CONSTRAINT "monstro_pkey" PRIMARY KEY ("id_monstro");
alter table monstro add CONSTRAINT "monstro_digimon_fkey" FOREIGN KEY ("id_digimon") REFERENCES "digimon"("id_digimon");
alter table monstro add CONSTRAINT "monstro_batalha_fkey" FOREIGN KEY ("id_batalha") REFERENCES "batalha"("id_batalha");

CREATE TABLE "chefe" (
  "defesa_extra" integer DEFAULT 0,
  "ataque_extra" integer DEFAULT 0,
  "vida_extra" integer DEFAULT 0,
    "velocidade_extra" integer DEFAULT 0,
    "id_monstro" UUID NOT NULL
);

alter table chefe add CONSTRAINT "chefe_monstro_fkey" FOREIGN KEY ("id_monstro") REFERENCES "monstro"("id_monstro");

CREATE TABLE "missao_jogador" (
    "id_missao" UUID NOT NULL,
    "id_jogador" UUID NOT NULL,
    "concluida" BOOL default false
);

alter table missao_jogador add CONSTRAINT "missao_jogador_pkey" PRIMARY KEY ("id_missao", "id_jogador");
alter table missao_jogador add CONSTRAINT "missao_jogador_jogador_fkey" FOREIGN KEY ("id_jogador") REFERENCES "jogador"("id_jogador");
alter table missao_jogador add CONSTRAINT "missao_jogador_missao_fkey" FOREIGN KEY ("id_missao") REFERENCES "missao"("id_missao");

CREATE TABLE "dialogo" (
    "id_dialogo" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "texto" varchar(255) NOT NULL,
    "id_missao" UUID,
    "id_npc" UUID not null
);

alter table dialogo add CONSTRAINT "dialogo_pkey" PRIMARY KEY ("id_dialogo");
alter table dialogo add CONSTRAINT "dialogo_missao_fkey" FOREIGN KEY ("id_missao") REFERENCES "missao"("id_missao");
alter table dialogo add CONSTRAINT "dialogo_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc");

CREATE TABLE "mercador_item" (
    "id_npc" UUID NOT NULL,
    "id_item" UUID NOT NULL,
    "preco" integer DEFAULT 0
);

alter table mercador_item add CONSTRAINT "mercador_item_pkey" PRIMARY KEY ("id_npc", "id_item");
alter table mercador_item add CONSTRAINT "mercador_item_npc_fkey" FOREIGN KEY ("id_npc") REFERENCES "npc"("id_npc");
alter table mercador_item add CONSTRAINT "mercador_item_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item");

CREATE TABLE "missao_item" (
    "id_missao" UUID NOT NULL,
    "id_item" UUID NOT NULL
);

alter table missao_item add CONSTRAINT "missao_item_pkey" PRIMARY KEY ("id_missao", "id_item");
alter table missao_item add CONSTRAINT "missao_item_missao_fkey" FOREIGN KEY ("id_missao") REFERENCES "missao"("id_missao");
alter table missao_item add CONSTRAINT "missao_item_item_fkey" FOREIGN KEY ("id_item") REFERENCES "item"("id_item");
