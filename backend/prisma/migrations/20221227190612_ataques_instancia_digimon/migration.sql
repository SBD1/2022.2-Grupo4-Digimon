/*
  Warnings:

  - Added the required column `instancia_digimon_id` to the `ataques` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ataques" ADD COLUMN     "instancia_digimon_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "ataques" ADD CONSTRAINT "ataques_instancia_digimon_id_fkey" FOREIGN KEY ("instancia_digimon_id") REFERENCES "instancia_digimon"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
