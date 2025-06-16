// db/db-init.js
const { Pool } = require('pg');
const pool = new Pool();

const createTableQuery = `
  CREATE TABLE IF NOT EXISTS pesanan (
    id SERIAL PRIMARY KEY,
    nama_pelanggan VARCHAR(255) NOT NULL,
    items JSONB,
    total_harga DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT NOW()
  );
`;

async function initializeDatabase() {
  try {
    await pool.query(createTableQuery);
    console.log('✅ Tabel pesanan berhasil dibuat/diverifikasi');
  } catch (err) {
    console.error('❌ Gagal membuat tabel:', err);
    process.exit(1); // Keluar dengan error
  } finally {
    await pool.end();
  }
}

module.exports = initializeDatabase;