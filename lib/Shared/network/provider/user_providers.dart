//Packages
import 'package:chat_app/Model/users_model.dart';
import 'package:chat_app/Shared/network/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/chat_model.dart';
import '../../../Modules/chat_page/page_of_chat.dart';
import '../services/database_Services.dart';
import '../services/navigation_service.dart';


class UsersPageProvider extends ChangeNotifier {
  AuthProvider _auth;

  late DatabaseService _database;
  late navigationServices _navigation;

  List<userModel>? users;
  late List<userModel> _selectedUsers;

  List<userModel> get selectedUsers {
    return _selectedUsers;
  }

  UsersPageProvider(this._auth) {
    _selectedUsers = [];
    getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static void getUsers({String? name}) async {
    List<userModel>? users;
    late List<userModel> _selectedUsers=[];
    try {
      DatabaseService.getUsers(name: name).then(
            (_snapshot) {
          users = _snapshot.docs.map(
                (_doc) {
              Map<String, dynamic> _data = _doc.data() as Map<String, dynamic>;
              _data["uid"] = _doc.id;
              return userModel.fromJSON(_data);
            },
          ).toList();
        },
      );
    } catch (e) {
      print("Error getting users.");
      print(e);
    }
  }

  void updateSelectedUsers(userModel _user) {
    if (_selectedUsers.contains(_user)) {
      _selectedUsers.remove(_user);
    } else {
      _selectedUsers.add(_user);
    }
    notifyListeners();
  }

  void createChat() async {
    try {
      //Create Chat
      List<String> _membersIds =
      _selectedUsers.map((_user) => _user.uid).toList();
      _membersIds.add(AuthProvider.User!.uid);
      bool _isGroup = _selectedUsers.length > 1;
      DocumentReference? _doc = await DatabaseService.createChat(
        {
          "is_group": _isGroup,
          "is_activity": false,
          "members": _membersIds,
        },
      );
      //Navigate To Chat Page
      List<userModel> _members = [];
      for (var _uid in _membersIds) {
        DocumentSnapshot _userSnapshot = await DatabaseService.getUser(_uid);
        Map<String, dynamic> _userData =
        _userSnapshot.data() as Map<String, dynamic>;
        _userData["uid"] = _userSnapshot.id;
        _members.add(
          userModel.fromJSON(
            _userData,
          ),
        );
      }
      ChatPage _chatPage = ChatPage(
        chat: Chat(
            uid: _doc!.id,
            currentUserUid: AuthProvider.User!.uid,
            members: _members,
            messages: [],
            activity: false,
            group: _isGroup),
      );
      _selectedUsers = [];
      notifyListeners();
      navigationServices.navigateToPage(_chatPage);
    } catch (e) {
      print("Error creating chat.");
      print(e);
    }
  }
}