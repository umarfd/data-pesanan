const { Pool } = require('pg');
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT
});

// Test connection
pool.query('SELECT NOW()')
  .then(res => console.log('DB Connected at:', res.rows[0].now))
  .catch(err => console.error('DB Connection Error:', err));

module.exports = pool;