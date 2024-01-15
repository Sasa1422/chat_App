import 'package:chat_app/Model/chat_model.dart';
import 'package:chat_app/Model/chats_massage_model.dart';
import 'package:chat_app/Model/users_model.dart';
import 'package:chat_app/Shared/network/provider/auth_provider.dart';
import 'package:chat_app/Shared/network/provider/chats_page_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_list_view.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late double height;
  late double width;
  late AuthProvider auth;
  late ChatsPageProvider PageProvider=ChatsPageProvider();
  @override
  Widget build(BuildContext context) {
    height =MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    auth=Provider.of<AuthProvider>(context);
    return MultiProvider(providers: [

      ChangeNotifierProvider<ChatsPageProvider>(
          create: (context)=>ChatsPageProvider()
      ),
    ],
     child:Builder(
       builder: (context){
         return  Scaffold(
           backgroundColor:const Color.fromRGBO(30, 29, 37, 1.0),
           appBar: AppBar(
             backgroundColor: const Color.fromRGBO(30, 29, 37, 1.0),
             title: const Padding(
               padding: EdgeInsets.all(10.0),
               child: Text('Hawar u',
                 style: TextStyle(
                   color: Colors.white,
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                 ),
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
               ),
             ),
             actions: [
               IconButton(onPressed: (){
                 AuthProvider.logout();
               }, icon:const Icon (Icons.logout),
                 color: Colors.blueAccent,)
             ],
           ),
           body:Container(
             padding: EdgeInsets.symmetric(
               horizontal: width*.03,
               vertical: height*.02,
             ),
             height: height*.98,
             width: width*.97,
             child:   Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.start,
               mainAxisSize: MainAxisSize.max,
               children: [
                 chatList(),

               ],
             ),
           ),

         );
       },
     )

    );
  }
  Widget chatList(){
    List<Chat>? chats=PageProvider.chats;
    return Expanded(
        child:Builder(
          builder: (BuildContext context) {
            if(chats != null){
              if(chats.isNotEmpty){
                return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context,index){
                      return chatTitle(chats[index]);
                    });
              }else{
                return const Center(
                  child: Text(
                    'No Chats Found',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }

            }else{
              return const Center(
                child: CircularProgressIndicator(color: Colors.white,),
              );
            }
          },)
    );
  }

  Widget chatTitle(Chat chat) {
    List<userModel> recepients =chat.Recepients()!;
    bool isActive = recepients.any((element) => element.wasRecentlyActive());
    String subtitleText='';
    if(chat.messages.isNotEmpty){
      subtitleText=chat.messages.first.type != MessageType.TEXT ?
      'Media Attachment' : chat.messages.first.content;

    }
    return CustomListViewTileWithActivity(
            height: height*.10,
            title: 'Mostafa Mohammed',
            subtitle: 'Hello',
            imagePath: 'https://i.pravatar.cc/300',
            isActive: isActive,
            isActivity: chat.activity,
            onTap: (){

            },
          );
  }
}
