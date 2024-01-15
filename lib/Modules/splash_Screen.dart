import 'dart:async';

import 'package:flutter/material.dart';

import 'auth_Screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startSplashTimer(){
    Timer(const Duration(seconds: 2),()=>Navigator.pushAndRemoveUntil(context ,MaterialPageRoute(builder: (context)=> LoginPage()) , (route) => false)

    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplashTimer();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Image(image: AssetImage('assets/images/img.png'),)),),
    );
  }
}
