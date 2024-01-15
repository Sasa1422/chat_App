import 'dart:async';

//Packages
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../../Model/chats_massage_model.dart';
import '../services/cloud_storage_Services.dart';
import '../services/database_Services.dart';
import '../services/media_Services.dart';
import '../services/navigation_service.dart';
import 'auth_provider.dart';

class ChatPageProvider extends ChangeNotifier {


  AuthProvider _auth;
  ScrollController _messagesListViewController;

  String _chatId;
  List<ChatMessage>? messages;

  late StreamSubscription _messagesStream;
  late StreamSubscription _keyboardVisibilityStream;
  late KeyboardVisibilityController _keyboardVisibilityController;

  String? _message;

  String get message {
    return message;
  }

  void set message(String _value) {
    _message = _value;
  }

  ChatPageProvider(this._chatId, this._auth, this._messagesListViewController) {
    _keyboardVisibilityController = KeyboardVisibilityController();
    listenToMessages();
    listenToKeyboardChanges();
  }

  @override
  void dispose() {
    _messagesStream.cancel();
    super.dispose();
  }

  void listenToMessages() {
    try {
      _messagesStream = DatabaseService.streamMessagesForChat(_chatId).listen(
            (_snapshot) {
          List<ChatMessage> _messages = _snapshot.docs.map(
                (_m) {
              Map<String, dynamic> _messageData =
              _m.data() as Map<String, dynamic>;
              return ChatMessage.fromJSON(_messageData);
            },
          ).toList();
          messages = _messages;
          notifyListeners();
          WidgetsBinding.instance!.addPostFrameCallback(
                (_) {
              if (_messagesListViewController.hasClients) {
                _messagesListViewController.jumpTo(
                    _messagesListViewController.position.maxScrollExtent);
              }
            },
          );
        },
      );
    } catch (e) {
      print("Error getting messages.");
      print(e);
    }
  }

  void listenToKeyboardChanges() {
    _keyboardVisibilityStream = _keyboardVisibilityController.onChange.listen(
          (_event) {
        DatabaseService.updateChatData(_chatId, {"is_activity": _event});
      },
    );
  }

  void sendTextMessage() {
    if (_message != null) {
      ChatMessage _messageToSend = ChatMessage(
        content: _message!,
        type: MessageType.TEXT,
        senderID: AuthProvider.User!.uid,
        sentTime: DateTime.now(),
      );
      DatabaseService.addMessageToChat(_chatId, _messageToSend);
    }
  }

  void sendImageMessage() async {
    try {
      PlatformFile? _file = await mediaServices.pickImageFromLibrary();
      if (_file != null) {
        String? _downloadURL = await CloudStorageService.saveChatImagetoStorage(
            _chatId, AuthProvider.User!.uid, _file);
        ChatMessage _messageToSend = ChatMessage(
          content: _downloadURL!,
          type: MessageType.IMAGE,
          senderID: AuthProvider.User!.uid,
          sentTime: DateTime.now(),
        );
        DatabaseService.addMessageToChat(_chatId, _messageToSend);
      }
    } catch (e) {
      print("Error sending image message.");
      print(e);
    }
  }

  void deleteChat() {
    goBack();
    DatabaseService.deleteChat(_chatId);
  }

  void goBack() {
    navigationServices.goBack();
  }
}