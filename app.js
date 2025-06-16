require('dotenv').config();
const express = require('express');
const app = express();
const pesananRoutes = require('./routes/pesananRoutes');

// Middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Set view engine
app.set('view engine', 'ejs');
app.set('views', './views');

// Routes
app.get('/', (req, res) => res.render('index'));
app.use('/pesanan', pesananRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});