const express=require('express')
const app=express();
const socket=require('socket.io')
const mongoose=require('mongoose')
const http=require('http')
const messageModel=require('./models/Message');


var server=http.createServer(app)
var io=socket(server)

const MongoClient = require("mongodb").MongoClient;

app.use(express.json())
app.use(express.urlencoded({extended:true}))
const url="mongodb://localhost:27017"
mongoose.connect(url).then(
()=>{
    console.log("Connection Sucessful")
    
}
).catch((e)=>{
    console.log(e);
})
const client = new MongoClient(url, { useNewUrlParser: true, useUnifiedTopology: true });
client.connect(err => {
    console.log("MongoDB connected for message.js");

});

io.on("connection",(socket)=>{
console.log("Hey connected");
socket.on("add",async({id,messagesent})=>{
    try{
        console.log(id,messagesent);
        let messages=new messageModel()
        messages.id=id

        messages.message=messagesent;

       const database = client.db("test");
       const msg=database.collection("messagemodels")
       await msg.insertOne(messages);

       
    }
    catch(e){
        console.log(e);
    }
})
socket.on("update",async()=>{
    try{
        
       const database = client.db("test");
       const msg=database.collection("messagemodels")

       var cursor=await msg.find();

       
        cursor.each(function(err, item) {

        
        if(item == null) {
            
            return;
            }
        console.log(item)
        socket.emit("Success",item);
        
        });
     
       
    }
    catch(e){
        console.log(e);
    }
})
})

server.listen(3000,"192.168.1.40",(req,res)=>{
    console.log(`The server started at port 3000`);
})