import 'package:flutter/material.dart';
import 'package:messagingsockets/Messageprovider.dart';
import 'package:provider/provider.dart';
import 'package:messagingsockets/Messagemodels.dart';
import 'socketmethods.dart';

class Home extends StatefulWidget {
  late String uname;
   Home({super.key, required this.uname});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController t1=TextEditingController();
  late  ScrollController _controller;

  @override
  void initState() {

    _controller=ScrollController();

    Logic().getting(context);

  }
  void _scrollToEnd() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollToEnd();
    });
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(centerTitle: true,title: Text("Lets Chat",style: TextStyle(color: Colors.white),),backgroundColor: Colors.deepPurple,),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0,75),
            child: ListView.builder(itemBuilder: (BuildContext context, int index) {
              return Provider.of<MessageProvider>(context,listen: false).models[index].id!=widget.uname?Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 250,
                   // height: 100,
                    decoration: BoxDecoration(color: Colors.deepPurple[200],borderRadius: BorderRadius.only(topLeft:Radius.zero,topRight: Radius.circular(20),bottomLeft:Radius.circular(20),bottomRight:Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: Text( Provider.of<MessageProvider>(context,listen: false).models[index].message,style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ),
              ):Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(color: Colors.deepPurple,borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),bottomLeft:Radius.circular(20),bottomRight:Radius.zero)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: Text(Provider.of<MessageProvider>(context,listen: false).models[index].message,style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ),
              );
            },itemCount:  Provider.of<MessageProvider>(context).models.length,
            controller: _controller,

              physics: BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,

            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(color: Colors.black54),
              child: ListTile(
                  selected: true,
                  selectedTileColor: Colors.black54,
                  tileColor: Colors.black54,
                  leading: Icon(Icons.emoji_emotions_outlined,color: Colors.deepPurple,),
                  title: TextField(controller: t1,decoration: InputDecoration(hintText: "Enter Your Message",hintStyle:TextStyle(color: Colors.white),),style: TextStyle(color: Colors.white),),
                  trailing:IconButton(icon:Icon(Icons.send),color: Colors.deepPurple,
                  onPressed: ()async {
                    Msg m = Msg(id: widget.uname, message: t1.text);

                    await Logic().comm(m, context);
                    Logic().update(context);


                    t1.clear();
                    Provider.of<MessageProvider>(context, listen: true)
                        .models
                        .clear();

                    setState(() {});
                  }
                  ),
          ),
            ),
          ),
        ],
      ),
    );
  }
}

