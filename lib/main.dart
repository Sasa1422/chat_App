import 'package:chat_app/Modules/auth_Screen/login_screen.dart';
import 'package:chat_app/Modules/auth_Screen/register_Screen.dart';
import 'package:chat_app/Shared/network/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Layout/home_page/Home_Page.dart';
import 'Shared/network/services/navigation_Service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context)=>AuthProvider()),
      ],
      child:  MaterialApp(
        title: 'Hawar u',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor:  Color.fromRGBO(36, 35, 49, 1.0),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
          )
        ),
       navigatorKey: navigationServices.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login':(context)=>LoginPage(),
          '/register':(context)=>RegisterPage(),
          '/home':(context)=>HomePage(),
        },

      ),
    );
  }
}
