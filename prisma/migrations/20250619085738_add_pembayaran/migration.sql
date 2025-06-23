-- CreateTable
CREATE TABLE "pembayaran" (
    "id" SERIAL NOT NULL,
    "pesanan_id" INTEGER NOT NULL,
    "metode" VARCHAR(50) NOT NULL,
    "jumlah_bayar" DOUBLE PRECISION NOT NULL,
    "status" VARCHAR(30) NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pembayaran_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_pesanan_id" ON "pembayaran"("pesanan_id");

-- AddForeignKey
ALTER TABLE "pembayaran" ADD CONSTRAINT "pembayaran_pesanan_id_fkey" FOREIGN KEY ("pesanan_id") REFERENCES "pesanan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
