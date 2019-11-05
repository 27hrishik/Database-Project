const mysql = require('mysql');
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "12345",
    database: "busdb"
  });

  db.connect((err)=>{
    if(err) console.log('Database Connection Failed...');
    else console.log('Database Connection Successful');
  });
  module.exports = db;