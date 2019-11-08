const express = require('express');
const Joi = require('@hapi/joi');
const router = express.Router();
const db = require('../Database/database');

// Handling User Request
router.post('/', (req, res) =>{
  const schema = Joi.object({
    operatorUsername:Joi.string().alphanum().min(3).max(10),
    password:Joi.string().alphanum().min(3).max(10),
    operatorName:Joi.string().min(1).max(10),
    mobile:Joi.number().min(1),
    email:Joi.string().email(),
    address:Joi.string().min(1).max(30),
  });
  const data = req.body;
  const check = schema.validate(data)
  if(check.error)
  {
      res.status(400).send(check.error.details[0].message);   
  }
  else{
    const sql = `insert into operator values 
    ('${data.operatorUsername}','${data.password}','${data.operatorName}','${data.address}','${data.email}',${data.mobile})`
  db.query(sql,(err,result)=>{
    if(err) 
    {
      switch(err.code)
      {
          case 'ER_DUP_ENTRY' :
              res.status(400).json('Username already taken');
              break;
          default :
              res.status(400).json(err.message);
              break;        
      }
    }
    else
      res.status(200).json('Operator Account Created Successfully');
  }); 
  }
});

router.get('/login', (req, res) =>{
    const schema = Joi.object({
      operatorUsername:Joi.string().alphanum().min(3).max(10),
      password:Joi.string().alphanum().min(3).max(10)
    });
    const data = req.query;
    const check = schema.validate(data)
    if(check.error)
    {
        res.status(400).send(check.error.details[0].message);   
    }
    else{
      const sql = `select password from operator 
      where operator_user_name = '${data.operatorUsername}'`;
      db.query(sql,(err,result)=>{
      if(err) 
      {
        switch(err.code)
        {
            default :
                res.status(400).json(err.message);
                break;        
        }
      }
      else
      {
        if(result[0])
        {
            if(data.password===result[0].password)
              res.status(200).json({status:'Login Successful',operatorUsername:data.operatorUsername});
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
  const schema = Joi.object({
    operatorUsername:Joi.string().min(3).max(10)     
  });
  const data = req.query;
  const check = schema.validate(data);
  if(check.error)
  {
        res.status(400).send(check.error.details[0].message);
  }
  else{
    const sql = `select * from operator 
    where operator_user_name = '${data.operatorUsername}'`;
    db.query(sql,(error,result)=>{
        if(error)
            res.status(400).json(error.message);
        else{
            console.log(result);
            if(result[0])
            {
                const data = {
                    operatorName:result[0].operator_name,
                    mobile:result[0].mobile,
                    email:result[0].email,
                    address:result[0].address,
                    operatorUsername:result[0].operator_user_name       
                };
                res.status(200).json(data);
            }
            else
                res.status(400).json('Server Error');        
        }    
    }); 
  }
});

router.post('/account', (req, res) =>{
    const schema = Joi.object({
        operatorName:Joi.string().min(1).max(10),
        mobile:Joi.number().min(1),
        email:Joi.string().email(),
        address:Joi.string().min(1).max(20),
        operatorUsername:Joi.string().min(3).max(10)
    });
    const data = req.body;
    const check = schema.validate(data);
    if(check.error)
    {
        res.status(400).send(check.error.details[0].message);
    }
    else{
        const sql = `update operator 
        set operator_name = '${data.operatorName}',
        address = '${data.address}',
        email = '${data.email}',
        mobile = ${data.mobile}
        where operator_user_name = '${data.operatorUsername}'`;
        db.query(sql,(error,result)=>{
            if(error)
                res.status(400).json(error.message);
            else
                res.status(200).json(data);    
        }); 
    }
});

router.delete('/account', (req, res) =>{
  const schema = Joi.object({
      operatorUsername:Joi.string().alphanum().min(1).max(10)
  });
  const data = req.query;
  const check = schema.validate(data);
  if(check.error)
  {
      res.status(400).send(check.error.details[0].message);
  }
  else{
    const sql = `delete from operator where operator_user_name = '${data.operatorUsername}'`;
    db.query(sql,(error,result)=>{
        if(error)
            res.status(400).send(error.message);
        else
            res.status(200).json("Deleted Successfully!!");    
    });
  }  
});

router.post('/account/password', (req, res) =>{
    const schema = Joi.object({
        operatorUsername:Joi.string().alphanum().min(3).max(10),
        oldPassword:Joi.string().alphanum().min(3).max(10),
        newPassword:Joi.string().alphanum().min(3).max(10)
    });
    const data = req.body;
    const check = schema.validate(data);
    if(check.error)
    {
        res.status(400).send(check.error.details[0].message);
    }
    else{
      const sql = `select password from operator where operator_user_name = '${data.operatorUsername}'`;
      db.query(sql,(error,result)=>{
          if(error)
              res.status(400).send(error.message);
          else{
                if(result[0]&&data.oldPassword===result[0].password)
                  {
                      const sql2 = `update operator set password = '${data.newPassword}' where operator_user_name = '${data.operatorUsername}'`;
                      db.query(sql2,(error,result)=>{
                            if(error)
                                res.status(400).send('Password Updation request Failed');
                            else
                                res.status(200).send('Password Updated Successfully');    
                      });
                  }
                  else
                    res.status(400).send('Enter correct Password');
            }    
      });
    } 
});

router.post('/buses', (req, res) =>{
    const schema = Joi.object({
            busOperator:Joi.string().min(1).max(10),
            busName:Joi.string().min(1).max(10),
            from:Joi.string().min(1).max(10),
            to:Joi.string().min(1).max(10),
            pickup:Joi.string().min(1).max(10),
            drop:Joi.string().min(1).max(10),
            deptTime:Joi.string(),
            arvlTime:Joi.string(),
            type:Joi.string().min(1).max(10),
            cost:Joi.number(),
            capacity:Joi.number().multiple(3),
            monday:Joi.bool(),
            tuesday:Joi.bool(),
            wednesday:Joi.bool(),
            thursday:Joi.bool(),
            friday:Joi.bool(),
            saturday:Joi.bool(),
            sunday:Joi.bool(),
    });
    const data = req.body;
    const check = schema.validate(data);
    if(check.error)
    {
        res.status(400).send(check.error.details[0].message);
    }
    else{
      const sql = `insert into bus_detail(operator_user_name,from_city,to_city,dept_time,arvl_time,capacity,bus_type,bus_name,
        pickup_location,drop_location,cost,monday,tuesday,wednesday,thursday,friday,saturday,sunday)
        values('${data.busOperator}','${data.from}','${data.to}','${data.deptTime}:00','${data.arvlTime}:00',${data.capacity},
        '${data.type}','${data.busName}','${data.pickup}','${data.drop}',${data.cost},
        ${data.monday},${data.tuesday},${data.wednesday},${data.thursday},${data.friday},${data.saturday},${data.sunday})`;
        db.query(sql,(error,result)=>{
          if(error)
              res.status(400).send(error.message);
          else
              res.status(200).json('Bus added Successfully');  
      });
    } 
});

router.get('/buses',(req,res)=>{
    const schema = Joi.object({
      operatorUsername:Joi.string().min(1).max(10)
    });
    const data = req.query;
    const check = schema.validate(data);
    if(check.error)
    {
        res.status(400).send(check.error.details[0].message);
    }
    else
    {
      const sql = `select operator_name from operator where operator_user_name = '${data.operatorUsername}'`;
      db.query(sql,(err,name)=>{
        if(err)
          res.status(400).send(err.message);
        else
        {
          const sql2 = `select bus_id,bus_name,from_city,to_city,dept_time,arvl_time,capacity,bus_type,cost from bus_detail
          where operator_user_name = '${data.operatorUsername}'`;
          db.query(sql2,(err,result)=>{
            if(err)
              res.status(400).send(err.message);
            else
            {
              const list = []
              result.forEach((value)=>{
                list.push({
                  id:value.bus_id,
                  busName:value.bus_name,
                  from:value.from_city,
                  to:value.to_city,
                  deptTime:value.dept_time,
                  arvlTime:value.arvl_time,
                  capacity:value.capacity,
                  type:value.bus_type,
                  price:value.cost
                });
              });
              res.status(200).json({operatorName:name[0].operator_name,listOfBuses:list});
            }  
          });
        }  
      });
    }
});

router.delete('/buses',(req,res)=>{
  const schema = Joi.object({
    id:Joi.number()
  });
  const data = req.query;
  const check = schema.validate(data);
  if(check.error)
  {
      res.status(400).send(check.error.details[0].message);
  }
  else
  {
    const sql = `delete from bus_detail where bus_id = ${data.id}`;
    db.query(sql,(err,result)=>{
      if(err)
        res.status(400).send(err.message);
      else
        res.status(200).send(`Bus with id ${data.id} is Successfully Deleted`);  
    });
  }
});

router.post('/buses/availability',(req,res)=>{
  const schema = Joi.object({
    id:Joi.number()
  });
  const data = req.body;
  const check = schema.validate(data);
  if(check.error)
  {
      res.status(400).send(check.error.details[0].message);
  }
  else
  {
    const sql = `call updateAvailability(${data.id})`;
    db.query(sql,(err,result)=>{
      if(err)
        res.status(400).send(err.message);
      else
        res.status(200).send(`Bus id: ${data.id} Availablity Updated for 30 Days`);  
    });
  }
});

module.exports = router;
