-- Periksa apakah tabel sudah ada
CREATE TABLE IF NOT EXISTS pesanan (
    id SERIAL PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    produk VARCHAR(100) NOT NULL,
    jumlah INTEGER NOT NULL,
    alamat TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Hanya buat fungsi jika belum ada
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Hanya buat trigger jika belum ada
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_trigger 
        WHERE tgname = 'update_pesanan_timestamp'
    ) THEN
        CREATE TRIGGER update_pesanan_timestamp
        BEFORE UPDATE ON pesanan
        FOR EACH ROW
        EXECUTE FUNCTION update_timestamp();
    END IF;
END $$;

-- Hanya insert data jika tabel kosong
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pesanan LIMIT 1) THEN
        INSERT INTO pesanan (nama_pelanggan, produk, jumlah, alamat) VALUES
        ('Budi Santoso', 'Laptop ASUS ROG', 1, 'Jl. Merdeka No. 123, Jakarta'),
        ('Ani Wijaya', 'Smartphone Samsung S21', 2, 'Jl. Sudirman No. 45, Bandung'),
        ('Citra Dewi', 'Headphone Sony WH-1000XM4', 3, 'Jl. Gatot Subroto No. 67, Surabaya');
    END IF;
END $$;

-- Buat view (akan replace jika sudah ada)
CREATE OR REPLACE VIEW view_pesanan AS
SELECT 
    id,
    nama_pelanggan,
    produk,
    jumlah,
    CONCAT(SUBSTRING(alamat, 1, 30), '...') AS alamat_pendek,
    TO_CHAR(created_at, 'DD-MM-YYYY HH24:MI') AS tanggal_pesan
FROM pesanan
ORDER BY created_at DESC;

-- Buat fungsi search
CREATE OR REPLACE FUNCTION search_pesanan(keyword VARCHAR(100))
RETURNS SETOF pesanan AS $$
BEGIN
    RETURN QUERY 
    SELECT * FROM pesanan 
    WHERE nama_pelanggan ILIKE '%' || keyword || '%'
       OR produk ILIKE '%' || keyword || '%'
       OR alamat ILIKE '%' || keyword || '%';
END;
$$ LANGUAGE plpgsql;

-- Buat index jika belum ada
CREATE INDEX IF NOT EXISTS idx_nama_pelanggan ON pesanan(nama_pelanggan);
CREATE INDEX IF NOT EXISTS idx_produk ON pesanan(produk);