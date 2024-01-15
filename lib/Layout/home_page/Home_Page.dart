import 'package:chat_app/Modules/users_page/users_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Modules/chat_page/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex=0;
  List<Widget> pages=[
    const ChatsPage(),
    const UsersPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: pages[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex ,
        onTap: (index){
          setState(() {
            currentindex=index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.chat_bubble_sharp),
              label: 'Chats'),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.supervised_user_circle_sharp),
              label: 'Users'),
        ],
      ),
    );
  }
}
