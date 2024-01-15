import 'dart:async';
import 'package:chat_app/Model/users_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/chat_model.dart';
import '../../../Model/chats_massage_model.dart';
import '../services/database_Services.dart';
import 'auth_provider.dart';

class ChatsPageProvider extends ChangeNotifier {


  List<Chat>? chats;

  late StreamSubscription _chatsStream;



  void getChats() async {
    try {
      _chatsStream =
          DatabaseService.getChatsForUser(AuthProvider.User!.uid).listen((_snapshot) async {
            chats = await Future.wait(
              _snapshot.docs.map(
                    (_d) async {
                  Map<String, dynamic> _chatData =
                  _d.data() as Map<String, dynamic>;
                  //Get Users In Chat
                  List<userModel> _members = [];
                  for (var _uid in _chatData["members"]) {
                    DocumentSnapshot _userSnapshot = await DatabaseService.getUser(_uid);
                    Map<String, dynamic> _userData =
                    _userSnapshot.data() as Map<String, dynamic>;
                    _userData["uid"] = _userSnapshot.id;
                    _members.add(
                      userModel.fromJSON(_userData),
                    );
                  }
                  //Get Last Message For Chat
                  List<ChatMessage> _messages = [];
                  QuerySnapshot _chatMessage =
                  await DatabaseService.getLastMessageForChat(_d.id);
                  if (_chatMessage.docs.isNotEmpty) {
                    Map<String, dynamic> _messageData =
                    _chatMessage.docs.first.data()! as Map<String, dynamic>;
                    ChatMessage _message = ChatMessage.fromJSON(_messageData);
                    _messages.add(_message);
                  }
                  //Return Chat Instance
                  return Chat(
                    uid: _d.id,
                    currentUserUid: AuthProvider.User!.uid,
                    members: _members,
                    messages: _messages,
                    activity: _chatData["is_activity"],
                    group: _chatData["is_group"],
                  );
                },
              ).toList(),
            );
            notifyListeners();
          });
    } catch (e) {
      print("Error getting chats.");
      print(e);
    }
  }
}