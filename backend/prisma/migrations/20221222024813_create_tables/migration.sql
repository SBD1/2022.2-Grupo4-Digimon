-- CreateTable
CREATE TABLE "jogadores" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "idade" INTEGER NOT NULL,
    "historia" TEXT NOT NULL,
    "vitorias_digimon" INTEGER NOT NULL,
    "vitorias_jogadores" INTEGER NOT NULL,
    "total_partidas" INTEGER NOT NULL,

    CONSTRAINT "jogadores_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "batalhas" (
    "id" SERIAL NOT NULL,
    "turno" INTEGER NOT NULL,
    "resultados" TEXT NOT NULL,
    "id_vencedor" INTEGER NOT NULL,

    CONSTRAINT "batalhas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ações" (
    "id" SERIAL NOT NULL,
    "eixo_x" INTEGER NOT NULL,
    "eixo_y" INTEGER NOT NULL,

    CONSTRAINT "ações_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "posições" (
    "id" SERIAL NOT NULL,
    "eixo_x" INTEGER NOT NULL,
    "eixo_y" INTEGER NOT NULL,

    CONSTRAINT "posições_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "digimon_batalha" (
    "id" SERIAL NOT NULL,
    "vida_batalha" INTEGER NOT NULL,

    CONSTRAINT "digimon_batalha_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "instancia_digimon" (
    "id" SERIAL NOT NULL,
    "xp" INTEGER NOT NULL,
    "nivel" INTEGER NOT NULL,
    "ataque" INTEGER NOT NULL,
    "vida" INTEGER NOT NULL,
    "velocidade" INTEGER NOT NULL,

    CONSTRAINT "instancia_digimon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ataques" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "dano" INTEGER NOT NULL,
    "casas" INTEGER NOT NULL,
    "direcao" TEXT NOT NULL,

    CONSTRAINT "ataques_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "digimon_base" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "vida_base" INTEGER NOT NULL,
    "ataque_base" INTEGER NOT NULL,
    "velocidade_base" INTEGER NOT NULL,
    "historia" TEXT NOT NULL,
    "vida_por_nivel" INTEGER NOT NULL,
    "ataque_por_nivel" INTEGER NOT NULL,
    "velocidade_por_nivel" INTEGER NOT NULL,

    CONSTRAINT "digimon_base_pkey" PRIMARY KEY ("id")
);
