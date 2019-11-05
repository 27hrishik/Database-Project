const express = require('express');
const Joi = require('@hapi/joi');
const router = express.Router();
const db = require('../Database/database');

// Handling User Request
router.post('/', (req, res) =>{
  const schema = Joi.object({
    username:Joi.string().alphanum().min(3).max(10),
    password:Joi.string().alphanum().min(3).max(10),
    customerName:Joi.string().min(1),
    mobile:Joi.number().min(1),
    email:Joi.string().email(),
    address:Joi.string().min(1).max(30),
    gender:Joi.string().length(1).allow('M','F'),
    age:Joi.number().max(150).min(12)
  });
  const data = req.body;
  const check = schema.validate(data)
  if(check.error)
  {
      res.status(400).send(check.error.details[0].message);   
  }
  else{
    const sql = `insert into user values 
    ('${data.username}','${data.password}','${data.customerName}',${data.mobile},'${data.email}','${data.address}','${data.gender}',${data.age})`;
    db.query(sql,(err,result)=>{
    if(err) 
    {
      switch(err.code)
      {
          case 'ER_DUP_ENTRY' :
              res.status(400).json('Username already taken');
              break;
          default :
              res.status(400).json('Server Error');
              break;        
      }
    }
    else
      res.status(200).json('Account Created Successfully');
  }); 
  }
});

router.get('/login', (req, res) =>{
  const schema = Joi.object({
    username:Joi.string().alphanum().min(3).max(10),
    password:Joi.string().alphanum().min(3).max(10)
  });
  const data = req.query;
  const check = schema.validate(data)
  if(check.error)
  {
      res.status(400).send(check.error.details[0].message);   
  }
  else{
    const sql = `select password from user 
    where user_name = '${data.username}'`;
    db.query(sql,(err,result)=>{
    if(err) 
    {
      switch(err.code)
      {
          default :
              res.status(400).json('Server Error');
              break;        
      }
    }
    else
    {
      if(result[0])
      {
          if(data.password===result[0].password)
            res.status(200).json({status:'Login Successful',username:data.username});
          else
            res.status(400).json('Enter Correct Password'); 
      }else
      {
          res.status(400).json('Username Doesn\'t Exist');
      }
    }
  });
  }
});

router.get('/account', (req, res) =>{
  res.status(200).send({ 
    username: req.query.username,
    customerName:'Customer Name',
    mobile:'Mobile',email:'Email',
    address:'address',
    gender:'Gender',
    age:12 });
});

router.post('/account', (req, res) =>{
  res.status(200).json(req.body);
});

router.delete('/account', (req, res) =>{
  res.status(200).json("Deleted Successfully!!");
});

router.post('/account/password', (req, res) =>{
  res.status(200).json("Password Updated");
});

module.exports = router;
