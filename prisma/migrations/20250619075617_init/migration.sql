-- CreateTable
CREATE TABLE "pesanan" (
    "id" SERIAL NOT NULL,
    "nama_pelanggan" VARCHAR(100) NOT NULL,
    "produk" VARCHAR(100) NOT NULL,
    "jumlah" INTEGER NOT NULL,
    "alamat" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pesanan_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_nama_pelanggan" ON "pesanan"("nama_pelanggan");

-- CreateIndex
CREATE INDEX "idx_produk" ON "pesanan"("produk");
