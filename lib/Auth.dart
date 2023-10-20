import 'package:flutter/material.dart';
import 'Home.dart';
import 'socketmethods.dart';
class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  TextEditingController t1=new TextEditingController();
  Logic m=Logic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
      centerTitle: true,
      title: Text("Welcome to Sukha Chat app"),
      backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(controller: t1,decoration: InputDecoration(hintText:"Enter an Username",hintStyle: TextStyle(color: Colors.white),icon: Icon(Icons.account_circle_rounded,color:Colors.white)),style: TextStyle(color: Colors.white),),
          ),
          MaterialButton(onPressed: (){
           // Navigator.pushReplacementNamed(context,'/home');
            if(t1.text.isNotEmpty) {
                Logic().update(context);
               Navigator.pushReplacement(context, MaterialPageRoute(
                   builder: (context) => Home(uname: t1.text)));
              //Navigator.popAndPushNamed(context,MaterialPageRoute(builder: (context)=>Home(uname: t1.text)));
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a valid message",style: TextStyle(color: Colors.white),),backgroundColor: Colors.deepPurple,));
            }
            },
            color: Colors.white,
            child: Text("Join Now"),
            )
        ],
      ),
    );
  }
}
