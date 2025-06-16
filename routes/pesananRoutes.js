const express = require('express');
const router = express.Router();
const Pesanan = require('../models/pesanan');

// List semua pesanan
router.get('/', async (req, res) => {
  try {
    const result = await Pesanan.getAll();
    res.render('pesanan/list', { pesanan: result.rows });
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
});

// Form tambah pesanan
router.get('/add', (req, res) => {
  res.render('pesanan/add');
});

// Proses tambah pesanan
router.post('/add', async (req, res) => {
  try {
    await Pesanan.create(req.body);
    res.redirect('/pesanan');
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
});

// Form edit pesanan
router.get('/edit/:id', async (req, res) => {
  try {
    const result = await Pesanan.getById(req.params.id);
    res.render('pesanan/edit', { pesanan: result.rows[0] });
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
});

// Proses edit pesanan
router.post('/edit/:id', async (req, res) => {
  try {
    await Pesanan.update(req.params.id, req.body);
    res.redirect('/pesanan');
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
});

// Hapus pesanan
router.get('/delete/:id', async (req, res) => {
  try {
    await Pesanan.delete(req.params.id);
    res.redirect('/pesanan');
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
});

module.exports = router;
