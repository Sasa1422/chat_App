
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class navigationServices{
  static GlobalKey<NavigatorState> navigatorKey=
      GlobalKey<NavigatorState>();

 static void removeAndNavigateToRoute(String rout){
    navigatorKey.currentState?.popAndPushNamed(rout);
  }
 static void navigateToRoute(String rout){
    navigatorKey.currentState?.pushNamed(rout);
  }

 static void navigateToPage(Widget page){
    navigatorKey.currentState?.push(MaterialPageRoute(builder:(context){
      return page ;
    }));
  }

 static void goBack(){
    navigatorKey.currentState?.pop();
  }
}