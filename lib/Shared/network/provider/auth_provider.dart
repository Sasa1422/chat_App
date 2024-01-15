
import 'package:chat_app/Shared/network/services/database_Services.dart';
import 'package:chat_app/Shared/network/services/navigation_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../Model/users_model.dart';
class AuthProvider extends ChangeNotifier {
  late final FirebaseAuth auth;
  late final DatabaseService databaseServices;
  late navigationServices navigation;
  static userModel? User;

  AuthProvider() {
     auth=FirebaseAuth.instance;
     auth.authStateChanges().listen((user) {
     if(user != null){
     print('Logged in');
       DatabaseService.updateUserLastSeenTime(user.uid);
     DatabaseService.getUser(user.uid).then(
          (snapshot){
       Map<String,dynamic> userData= snapshot.data()! as Map<String,dynamic>;
     if(User !=null) {
     User=userModel.fromJSON({
             "uid":User!.uid,
           "name":userData["name"],
         "email": userData["email"],
      "imageURL": userData["imageURL"],
      "lastActive": userData["lastActive"]});
     }
     }
     );
      navigationServices.removeAndNavigateToRoute('/home');
      }
      else{
      print('No Authentication');
    navigationServices.removeAndNavigateToRoute('/login');
     }
    });
}
    static Future<void> loginUsingEmailAndpassword
    (String email, String password)async{
      FirebaseAuth auth = FirebaseAuth.instance;
      try {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ).then((value) {
          auth.authStateChanges().listen((user) {
            if (user != null) {
              print('Logged in');
              DatabaseService.updateUserLastSeenTime(user.uid);
              DatabaseService.getUser(user.uid).then(
                      (snapshot) {
                    Map<String, dynamic> userData = snapshot.data()! as Map<
                        String,
                        dynamic>;
                    if (User != null) {
                      User = userModel.fromJSON({
                        "uid": User!.uid,
                        "name": userData["name"],
                        "email": userData["email"],
                        "imageURL": userData["imageURL"],
                        "lastActive": userData["lastActive"]});
                    }
                  }
              );
              navigationServices.removeAndNavigateToRoute('/home');
            }
            else {
              print('No Authentication');
              navigationServices.removeAndNavigateToRoute('/login');
            }
          });
        });
        print(auth.currentUser);
      } on FirebaseAuthException {
        print('Error logging user into firbase');
      } catch (e) {
        print(e.toString());
      }
    }

    static void userRegister({
      required String name,
      required String email,
      required String password,
    }) {
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        return value.user!.uid;
      }).catchError((e) {
        print(e.toString());
      });
    }

    static Future<String?> regiserUsersUsingEmailAndpassword
    (String email, String password)async{
      FirebaseAuth auth = FirebaseAuth.instance;

      try {
        UserCredential credentials = await auth.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        return credentials.user!.uid;
      } on FirebaseAuthException {
        print('Error registering user');
      }
      catch (e) {
        print(e.toString());
      }
      return null;
    }
    static Future<void> logout()async{
      FirebaseAuth auth = FirebaseAuth.instance;

      try {
        await auth.signOut();
      } catch (e) {
        print(e.toString());
      }
    }
  }
