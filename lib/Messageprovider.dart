import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Messagemodels.dart';
class MessageProvider with ChangeNotifier{
List<Msg>models=[];
void add(Msg m){
  models.add(m);
  notifyListeners();
}
void print(String s){
  for(int i=0;i<models.length;i++){
    print("${models[i].id} ${models[i].message}");
  }
}

}