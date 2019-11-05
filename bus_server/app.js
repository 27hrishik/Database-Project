const express = require('express');
const userRoute = require('./routes/user');
const operatorRoute = require('./routes/operator');
const app = express();

const port = process.env.port || 3000;

//setting routes
app.use(express.json());
app.use((req, res, next)=> { 
  res.header("Access-Control-Allow-Origin", "*"); 
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  res.header('Access-Control-Allow-Methods', 'PUT, POST, GET, DELETE, OPTIONS'); 
  next(); 
});
app.use('/user', userRoute);
app.use('/operator',operatorRoute);


app.listen(port,()=>{
  console.log(`Server Running On Port ${port}...`);
});

module.exports = app;
