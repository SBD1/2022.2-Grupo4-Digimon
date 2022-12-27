/*
  Warnings:

  - Added the required column `jogador_id` to the `instancia_digimon` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "instancia_digimon" ADD COLUMN     "jogador_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "instancia_digimon" ADD CONSTRAINT "instancia_digimon_jogador_id_fkey" FOREIGN KEY ("jogador_id") REFERENCES "jogadores"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
