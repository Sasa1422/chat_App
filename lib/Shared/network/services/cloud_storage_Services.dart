import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String USER_COLLECTION='Users';

class CloudStorageService{
  final FirebaseStorage storage=FirebaseStorage.instance;

  CloudStorageService(){}

  static Future<String?> saveUserImagetoStorage(String uid,PlatformFile file)async{
    final FirebaseStorage storage=FirebaseStorage.instance;
   try{
     Reference ref=storage.ref().child('images/users/$uid/profile.${file.extension}');
 UploadTask task=ref.putFile(File(file.path!));
 return await task.then((resalut){
   return resalut.ref.getDownloadURL();
 });
   }catch(e){
     print(e.toString());
   }
   return null;
  }
static  Future<String?> saveChatImagetoStorage(String chatID,String userID,PlatformFile file)async{
  final FirebaseStorage storage=FirebaseStorage.instance;
    try{
      Reference ref=storage.ref().child('images/chats/$chatID/${userID} ${Timestamp.now().millisecondsSinceEpoch}.${file.extension}');
      UploadTask task=ref.putFile(File(file.path!));
      return await task.then((resalut){
        return resalut.ref.getDownloadURL();
      });
     }catch(e){
      print(e.toString());
    }
    return null;
  }
}