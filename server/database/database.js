// database.js
const mysql = require('mysql2/promise');

const connection = mysql.createPool({
  host: 'localhost',
  user: 'root',
  database: 'apay',
  password: '',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

module.exports = { connection };
