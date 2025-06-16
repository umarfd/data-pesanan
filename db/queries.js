// db/queries.js
const pool = require('./db'); // Import dari file db.js lokal

module.exports = {
  getAllPesanan: async () => {
    try {
      const result = await pool.query('SELECT * FROM pesanan ORDER BY id DESC');
      return result;
    } catch (err) {
      console.error('Error in getAllPesanan:', err);
      throw err;
    }
  },

  getPesananById: async (id) => {
    try {
      const result = await pool.query('SELECT * FROM pesanan WHERE id = $1', [id]);
      return result;
    } catch (err) {
      console.error('Error in getPesananById:', err);
      throw err;
    }
  },

  createPesanan: async (data) => {
    try {
      const result = await pool.query(
        `INSERT INTO pesanan 
        (nama_pelanggan, produk, jumlah, alamat) 
        VALUES ($1, $2, $3, $4) 
        RETURNING *`,
        [data.nama_pelanggan, data.produk, data.jumlah, data.alamat]
      );
      return result;
    } catch (err) {
      console.error('Error in createPesanan:', err);
      throw err;
    }
  },

  updatePesanan: async (id, data) => {
    try {
      const result = await pool.query(
        `UPDATE pesanan 
        SET nama_pelanggan = $1, produk = $2, jumlah = $3, alamat = $4 
        WHERE id = $5 
        RETURNING *`,
        [data.nama_pelanggan, data.produk, data.jumlah, data.alamat, id]
      );
      return result;
    } catch (err) {
      console.error('Error in updatePesanan:', err);
      throw err;
    }
  },

  deletePesanan: async (id) => {
    try {
      const result = await pool.query('DELETE FROM pesanan WHERE id = $1', [id]);
      return result;
    } catch (err) {
      console.error('Error in deletePesanan:', err);
      throw err;
    }
  }
};