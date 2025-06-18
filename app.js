require('dotenv').config();
const express = require('express');
const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');
const app = express();

// Konfigurasi koneksi database
const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
});

// Middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Set view engine
app.set('view engine', 'ejs');
app.set('views', './views');

// Fungsi inisialisasi database
async function initDatabase() {
  try {
    const sql = fs.readFileSync(path.join(__dirname, 'db', 'init.sql'), 'utf8');
    await pool.query(sql);
    console.log('✅ Database berhasil diinisialisasi!');
  } catch (err) {
    console.error('❌ Gagal inisialisasi database:', err.message);
  }
}

// Jalankan inisialisasi sebelum server start
initDatabase().then(() => {
  // Routes
  app.get('/', (req, res) => res.render('index'));
  app.use('/pesanan', require('./routes/pesananRoutes'));

  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
});