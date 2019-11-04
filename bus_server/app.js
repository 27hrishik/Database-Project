var express = require('express');

var requestHandler = require('./routes/requesthandler');

var app = express();
const port = process.env.port || 3000;

//setting routes
app.use(express.json());
app.use((req, res, next)=> { 
  res.header("Access-Control-Allow-Origin", "*"); 
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  res.header('Access-Control-Allow-Methods', 'PUT, POST, GET, DELETE, OPTIONS'); 
  next(); 
});
app.use('/', requestHandler);

app.listen(port,()=>{
  console.log(`Server Running On Port ${port}...`);
});

module.exports = app;
