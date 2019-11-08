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
  const schema = Joi.object({
    username:Joi.string().min(3).max(10)     
  });
  const data = req.query;
  const check = schema.validate(data);
  if(check.error)
  {
        res.status(400).send(check.error.details[0].message);
  }
  else{
    const sql = `select * from user 
    where user_name = '${data.username}'`;
    db.query(sql,(error,result)=>{
        if(error)
            res.status(400).json(error.message);
        else{
            if(result[0])
            {
                const data = {
                  username: result[0].user_name,
                  customerName:result[0].name,
                  mobile:result[0].mobile,
                  email:result[0].email,
                  address:result[0].email,
                  gender:result[0].gender,
                  age:result[0].age       
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
    customerName:Joi.string().min(1).max(10),
    mobile:Joi.number().min(1),
    email:Joi.string().email(),
    address:Joi.string().min(1).max(20),
    username:Joi.string().min(3).max(10),
    age:Joi.number(),
    gender:Joi.string().allow('M','F')
  });
  const data = req.body;
  const check = schema.validate(data);
  if(check.error)
  {
      res.status(400).send(check.error.details[0].message);
  }
  else{
      const sql = `update user 
      set name = '${data.customerName}',
      address = '${data.address}',
      email = '${data.email}',
      mobile = ${data.mobile},
      age = ${data.age},
      gender = '${data.gender}'
      where user_name = '${data.username}'`;
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
    username:Joi.string().alphanum().min(1).max(10)
  });
  const data = req.query;
  const check = schema.validate(data);
  if(check.error)
  {
      res.status(400).send(check.error.details[0].message);
  }
  else{
    const sql = `delete from user where user_name = '${data.username}'`;
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
      username:Joi.string().alphanum().min(3).max(10),
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
    const sql = `select password from user where user_name = '${data.username}'`;
    db.query(sql,(error,result)=>{
        if(error)
            res.status(400).send(error.message);
        else{
              if(result[0]&&data.oldPassword===result[0].password)
                {
                    const sql2 = `update user set password = '${data.newPassword}' where user_name = '${data.username}'`;
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

router.get('/buses', (req, res) =>{
  const schema = Joi.object({
    source:Joi.string().alphanum().min(1).max(10),
    destination:Joi.string().alphanum().min(1).max(10),
    dateOfJourney:Joi.string()
  });
  const data = req.query;
  const check = schema.validate(data);
  if(check.error)
  {
      res.status(400).send(check.error.details[0].message);
  }
  else{
    const sql = `select bus_id,operator_name,bus_name,bus_type,pickup_location,drop_location,dept_time,arvl_time,seats_available,cost
    from ((bus_detail natural join operator) natural join seat_availability)
    where from_city = '${data.source}' and to_city = '${data.destination}' and date_of_journey = '${data.dateOfJourney}'`;
    db.query(sql,(error,result)=>{
        if(error)
            res.status(400).send(error.message);
        else
            {
                const list = []
                result.forEach((value)=>{
                  list.push({
                    id:value.bus_id,
                    operatorName:value.operator_name,
                    busName:value.bus_name,
                    pickup:value.pickup_location,
                    drop:value.drop_location,
                    deptTime:value.dept_time,
                    arvlTime:value.arvl_time,
                    type:value.bus_type,
                    seatAvailable:value.seats_available,
                    price:value.cost
                  });
                });
                res.status(200).json({listOfBuses:list,date:data.dateOfJourney});   
            }    
    });
  }  
  });

  router.get('/buses/availability', (req, res) =>{
    const schema = Joi.object({
      id:Joi.number(),
      date:Joi.string()
    });
    const data = req.query;
    const check = schema.validate(data);
    if(check.error)
    {
        res.status(400).send(check.error.details[0].message);
    }
    else{
      const sql = `select seat_no
      from seat
      where bus_id = ${data.id} and date_of_journey = '${data.date}' and check_availability is not null`;
      db.query(sql,(error,result)=>{
          if(error)
              res.status(400).send(error.message);
          else
              {
                  const sql2 = `select capacity from bus_detail where bus_id = ${data.id}`
                  db.query(sql2,(error,result2)=>{
                    if(error)
                      res.status(400).send(error.message);
                    else{
                      const list = []
                      result.forEach((value)=>{
                        list.push(value.seat_no);
                      });
                      res.status(200).json({booked:list,capacity:result2[0].capacity});
                    }
                  });   
              }    
      });
    }  
    });

    router.post('/buses/ticket', async (req, res) =>{
      const pasSchema = Joi.object({
        seatno:Joi.number(),
        name:Joi.string().min(1).max(10),
        age:Joi.number(),
        gender:Joi.string().allow('M','F')
      });
      const schema = Joi.object({
        id:Joi.number(),
        username:Joi.string().min(3).max(10),
        dateOfJourney:Joi.string(),
        passengers:Joi.array().items(pasSchema)
      });
      const data = req.body;
      const check = schema.validate(data);
      if(check.error)
      {
          res.status(400).send(check.error.details[0].message);
      }
      else{
        const sql = `insert into ticket(date_of_journey,user_name,bus_id) values
        ('${data.dateOfJourney}','${data.username}',${data.id})`;
        db.query(sql,(err)=>{
          if(err)
            res.status(400).send(err.message);
          else{
            const sql2 = `select max(ticket_id) as ticket_id from ticket`;
            db.query(sql2,(err,result)=>{
              if(err)
                res.status(400).send(err.message);
              else{
                let ticket_id = result[0].ticket_id;
                let promises = [];
                data.passengers.forEach((value)=>{
                  promises.push(
                    new Promise((resolve,reject)=>{
                      const sql3 = `insert into seat_booked values (${ticket_id},${value.seatno},'${value.name}',${value.age},'${value.gender}')`;
                      db.query(sql3,(err,res)=>{
                        if(err)
                          throw err;
                        else
                          resolve(value.seatno);  
                      }); 
                    })
                  );
                });
                Promise.all(promises).then((result)=>{
                  console.log(result);
                  res.status(200).send('Booking '+result);
                }).catch((err)=>{
                  res.status(200).send(err.message);
                });
              }    
            }); 
          }    
        });
      } 
    });

    router.get('/booking', (req, res) =>{
      const schema = Joi.object({
        username:Joi.string().min(1).max(10)
      });
      const data = req.query;
      const check = schema.validate(data);
      if(check.error)
      {
          res.status(400).send(check.error.details[0].message);
      }
      else{
        const sql = `select ticket_id,bus_name,from_city,to_city,dept_time,arvl_time,cost,count(*) as seats_booked
        from ((ticket left join bus_detail on ticket.bus_id=bus_detail.bus_id ) natural join seat_booked)
        where user_name = '${data.username}'
        group by ticket_id`;
        db.query(sql,(error,result)=>{
            if(error)
                res.status(400).send(error.message);
            else
                {
                    let list = []
                    result.forEach((value)=>{
                      list.push({
                        id:value.ticket_id,
                        busName:value.bus_name?value.bus_name:'Bus Canceled',
                        from:value.from_city,
                        to:value.to_city,
                        deptTime:value.dept_time,
                        arvlTime:value.arvl_time,
                        seatsBooked:value.seats_booked,
                        price:value.cost?value.cost * value.seats_booked:'Refund'
                      });
                    });
                    console.log(list);
                    res.status(200).json({listOfTickets:list});   
                }    
        });
      }  
      });

module.exports = router;
