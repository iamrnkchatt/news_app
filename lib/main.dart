import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scnews/Screens/home.dart';
import 'package:scnews/Screens/nav_screen.dart';
import 'package:scnews/Screens/splash.dart';
import 'package:scnews/Screens/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sc/St News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
