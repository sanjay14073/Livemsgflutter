

import 'package:flutter/cupertino.dart';

import 'socketclient.dart';
import 'package:messagingsockets/Messageprovider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'Messagemodels.dart';
import 'package:provider/provider.dart';
class Logic{
  final _socketclient=Client.instance?.socket!;

  Socket get socketclient => _socketclient!;
  //emiting elements
  Future<void> comm(Msg m,BuildContext context)async{
    Provider.of<MessageProvider>(context,listen: false).models.clear();
    _socketclient?.emit("add",{"id":m.id,"messagesent":m.message});
  }
  void update(BuildContext context){
    Provider.of<MessageProvider>(context,listen: false).models.clear();
    _socketclient!.emit("update",{});
  }

  //listeners
  void getting(BuildContext context){
    Provider.of<MessageProvider>(context,listen: false).models.clear();
    _socketclient!.on("Success", (arr)=>{
      Provider.of<MessageProvider>(context,listen: false).add(Msg(id: arr["id"], message: arr["message"])),

    });
  } 
}