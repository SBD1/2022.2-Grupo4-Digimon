/*
  Warnings:

  - You are about to drop the column `eixo_x` on the `ações` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "ações" DROP COLUMN "eixo_x",
ADD COLUMN     "foi_realizada" BOOLEAN NOT NULL DEFAULT false;
