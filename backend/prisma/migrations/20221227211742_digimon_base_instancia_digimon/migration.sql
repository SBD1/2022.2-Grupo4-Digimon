/*
  Warnings:

  - Added the required column `digimon_base_id` to the `instancia_digimon` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "instancia_digimon" ADD COLUMN     "digimon_base_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "instancia_digimon" ADD CONSTRAINT "instancia_digimon_digimon_base_id_fkey" FOREIGN KEY ("digimon_base_id") REFERENCES "digimon_base"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
