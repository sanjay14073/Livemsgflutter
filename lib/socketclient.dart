import 'package:socket_io_client/socket_io_client.dart' as io;
//singleton class pattern why this? to create only a single instance of the class multiple instances not supported
class Client{
  io.Socket?socket;
  static Client? _instance;
  //private constructor
  Client._internal(){
    //print("request sent");
    socket=io.io('http://192.168.1.40:3000',<String,dynamic>{
      'transports':['websocket'],
      'autoConnect':false,
    });
    socket!.connect();
  }
  static Client? get instance {
    _instance ??=Client._internal();
    return _instance;
  }
}
