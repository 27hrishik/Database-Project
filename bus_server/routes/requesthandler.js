var express = require('express');
var mysql = require('mysql');
var router = express.Router();

var db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "12345",
  database: "busdb"
});

db.connect((err)=>{
  if(err) throw err;
  console.log("Database Connected successfully");
});

// Handling User Request
router.get('/user/login', (req, res) =>{
  res.status(200).send({ status: 'Login Successful',username:req.query.username,password:req.query.password });
});

router.get('/user/account', (req, res) =>{
  res.status(200).send({ 
    username: req.query.username,
    customerName:'Customer Name',
    mobile:'Mobile',email:'Email',
    address:'address',
    gender:'Gender',
    age:12 });
});

router.post('/user', (req, res) =>{
  res.status(200).json("Account Created Successfully");
});

router.post('/user/account', (req, res) =>{
  res.status(200).json(req.body);
});

router.delete('/user/account', (req, res) =>{
  res.status(200).json("Deleted Successfully!!");
});

router.post('/user/account/password', (req, res) =>{
  res.status(200).json("Password Updated");
});

module.exports = router;
