/*
  Warnings:

  - You are about to drop the column `produkId` on the `pesanan` table. All the data in the column will be lost.
  - You are about to drop the `produk` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `produk` to the `pesanan` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "pesanan" DROP CONSTRAINT "pesanan_produkId_fkey";

-- DropIndex
DROP INDEX "idx_produk_id";

-- AlterTable
ALTER TABLE "pesanan" DROP COLUMN "produkId",
ADD COLUMN     "produk" VARCHAR(100) NOT NULL,
ALTER COLUMN "created_at" DROP NOT NULL,
ALTER COLUMN "updated_at" DROP NOT NULL;

-- DropTable
DROP TABLE "produk";

-- CreateIndex
CREATE INDEX "idx_produk" ON "pesanan"("produk");
