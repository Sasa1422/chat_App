import 'package:chat_app/Model/chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Shared/network/provider/auth_provider.dart';

class PageChats extends StatefulWidget {
  final Chat chat;
  const PageChats({super.key, required this.chat});

  @override
  State<PageChats> createState() => _PaggeChatsState();
}

class _PaggeChatsState extends State<PageChats> {
  late double height;
  late double width;
  late AuthProvider auth;
  late GlobalKey<FormState> messageFormState;
  late ScrollController messagesListViewController;
  @override
  Widget build(BuildContext context) {
    height =MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    auth=Provider.of<AuthProvider>(context);
    return  Scaffold(
      backgroundColor:const Color.fromRGBO(30, 29, 37, 1.0),
      appBar: AppBar(
        leading: IconButton(onPressed: (){

        },
            icon: const Icon(Icons.arrow_back_ios_sharp,
              color: Color.fromRGBO(0, 82, 218, 1.0),)),
        title: Text(widget.chat.title(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),),
        actions: [
          IconButton(onPressed: (){},
              icon: const Icon(Icons.delete,
              color: Color.fromRGBO(0, 82, 218, 1.0),))
        ],

      ),
      body:SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width*.03,
          vertical: height*.02,
        ),
          height: height,
          width: width,
          child:  const Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


            ],

          ),
        ),
      ) ,
    );
  }
}
