

import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType{
  TEXT,
  IMAGE,
  UNKOWN,
}
class ChatMessage{
  late  String senderID;
 late   MessageType type;
 late   String content;
 late   DateTime sentTime;

   ChatMessage({
     required this.senderID,
     required this.type,
     required this.content,
     required this.sentTime,
});
 factory  ChatMessage.fromJSON(Map<String,dynamic> jeson){
     MessageType messageType;
     switch(jeson['type']){
       case "text":
         messageType=MessageType.TEXT;
         break;
       case "image":
         messageType=MessageType.IMAGE;
         break;
       default:
         messageType=MessageType.UNKOWN;
     }
   return ChatMessage(
         senderID: jeson["senderID"],
         type: messageType,
         content: jeson["content"],
         sentTime:jeson["sentTime"].toDate()
     );
   }
   Map<String,dynamic> toJson(){
     String messageType;
     switch(type){
       case  MessageType.TEXT:
         messageType="text";
         break;
       case MessageType.IMAGE:
         messageType= "image";
         break;
       default:
         messageType="";
     }
     return {
       "content":content,
       "type":messageType,
       "senderID":senderID,
       "sentTime":Timestamp.fromDate(sentTime),

     };
}
}