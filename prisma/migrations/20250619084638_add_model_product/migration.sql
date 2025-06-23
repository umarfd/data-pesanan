/*
  Warnings:

  - You are about to drop the `Keranjang` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Pesanan` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Keranjang" DROP CONSTRAINT "Keranjang_user_id_fkey";

-- DropForeignKey
ALTER TABLE "Pesanan" DROP CONSTRAINT "Pesanan_user_id_fkey";

-- DropTable
DROP TABLE "Keranjang";

-- DropTable
DROP TABLE "Pesanan";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "produk" (
    "id" SERIAL NOT NULL,
    "nama" VARCHAR(100) NOT NULL,
    "harga" DOUBLE PRECISION NOT NULL,
    "stok" INTEGER NOT NULL,
    "kategori" VARCHAR(50) NOT NULL,
    "deskripsi" TEXT,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "produk_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pesanan" (
    "id" SERIAL NOT NULL,
    "nama_pelanggan" VARCHAR(100) NOT NULL,
    "produkId" INTEGER NOT NULL,
    "jumlah" INTEGER NOT NULL,
    "alamat" TEXT,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pesanan_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_nama_produk" ON "produk"("nama");

-- CreateIndex
CREATE INDEX "idx_kategori_produk" ON "produk"("kategori");

-- CreateIndex
CREATE INDEX "idx_nama_pelanggan" ON "pesanan"("nama_pelanggan");

-- CreateIndex
CREATE INDEX "idx_produk_id" ON "pesanan"("produkId");

-- AddForeignKey
ALTER TABLE "pesanan" ADD CONSTRAINT "pesanan_produkId_fkey" FOREIGN KEY ("produkId") REFERENCES "produk"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
