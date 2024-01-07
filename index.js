const express = require('express');
const bodyParser = require('body-parser');


const http = require('http');
const app = express();

const server = http.createServer(app);


const io = require('socket.io')(server)



// channel 

io.on("connection", (client) => {
    console.log('new client connected!');
   
    console.log(client.id);
    // on -> name of event -> listen -> data 
    client.on('message' , (data) => {

        console.log(data) ;

    //  client.emit('response', data) ;
        
   //  io.to(client.id).emit('response' , data) ;
        // send message to a user

        //     client.emit('response' , `hello ` + data.name + ' Welcome') 
     
        // send message to all users 

        //   io.emit('response',"Welcome Every Body");
    

     // send a message from client to all users 

     client.broadcast.emit('response', data +' group message') ;
         
    // send a message to spicfic user based on his ID 

   
}) 
    // emit -> send to client    
})
  

 
app.get('/', (req, res) => {
    res.send('Api Working successfully');
});




server.listen(3000, () => {
    console.log('server http://localhost:3000');
});







