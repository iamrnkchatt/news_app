import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scnews/Screens/login.dart';
import 'package:scnews/Screens/nav_screen.dart';
import 'package:scnews/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getData();
    getUrlData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      color: Colors.white,
      child: Scaffold(
        backgroundColor: orange,
        body: Center(
          child: Container(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(width * 0.02),
              height: width * 0.6,
              width: width * 0.6,
              child: const Image(image: AssetImage('assets/logo.png')),
            ),
          ),
        ),
      ),
    );
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Email = prefs.getString(userEmailKey);
    String? Image = prefs.getString(userImageKey);
    String? Name = prefs.getString(userNameKey);
    if (Email != null && Name != null && Image != null && Email.isNotEmpty) {
      Constant.userEmail = Email;
      Constant.userImage = Image;
      Constant.userName = Name;
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavScreen()), (route) => false);
      });
    }else if(Email != null && Email == "Skip"){
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavScreen()), (route) => false);
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login()), (route) => false);
      });
    }
  }

  void getUrlData() async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("BaseUrls");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          Map<String, dynamic> urlsDetail = jsonDecode(jsonEncode(event.snapshot.value));
          Constant.basePath = urlsDetail['image_path'];
        } on Exception catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
