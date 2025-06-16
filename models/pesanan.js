const db = require('../db/queries');

class Pesanan {
  static async getAll() {
    return await db.getAllPesanan();
  }

  static async getById(id) {
    return await db.getPesananById(id);
  }

  static async create(data) {
    return await db.createPesanan(data);
  }

  static async update(id, data) {
    return await db.updatePesanan(id, data);
  }

  static async delete(id) {
    return await db.deletePesanan(id);
  }
}

module.exports = Pesanan;
