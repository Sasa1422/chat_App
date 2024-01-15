import 'dart:core';
import 'package:chat_app/Model/chats_massage_model.dart';
import 'package:chat_app/Model/users_model.dart';

class Chat{

   String uid;
   String currentUserUid;
   bool? active;
   bool? group;
   bool activity;
   List <userModel> members;
    List<ChatMessage> messages;
  late  List<userModel> recepients;

  Chat({
    required this.uid,
    required this.currentUserUid,
    required this.group,
    required this.members,
    required this.messages,
    required this.activity,

}){
   recepients=members.where((i) => i.uid != currentUserUid
   ).toList() ;
  }
   List<userModel>? Recepients(){
    return recepients;
   }
   String title(){
    return group! ?
          recepients.first.name
        : recepients.map((user) => user.name ).join(",");
   }
   String imageURL(){
    return group! ? recepients.first.imageURL :
        'https://depositphotos.com/vector/grunge-design-2983099.html';
   }


}