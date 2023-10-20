const mongoose=require("mongoose");
const messageSchema=mongoose.Schema({
    id:{type:String},
    message:{type:String},
})
module.exports=mongoose.model("messageModel",messageSchema);