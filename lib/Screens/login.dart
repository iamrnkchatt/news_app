import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scnews/Models/usermodel.dart';
import 'package:scnews/Screens/interest.dart';
import 'package:scnews/Screens/nav_screen.dart';
import 'package:scnews/Services/user_dao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:scnews/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _googleSignIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        await auth.signInWithCredential(GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
        DatabaseReference db = FirebaseDatabase.instance.reference().child("users");
        db.child(googleUser.id).set(({'email': googleUser.email.toString(), 'name': googleUser.displayName.toString(), 'photourl': googleUser.photoUrl.toString()})).asStream();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Constant.userEmail = googleUser.email.toString();
        Constant.userName = googleUser.displayName.toString();
        Constant.userImage = googleUser.photoUrl.toString();
        prefs.setString(userEmailKey, Constant.userEmail);
        prefs.setString(userNameKey, Constant.userName);
        prefs.setString(userImageKey, Constant.userImage);
        prefs.setString("user_id", googleUser.id);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavScreen()));
      }
    }
  }

  _signInWithFacebook() async {
    try {
      String email, name, photourl;
      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final userdata = await FacebookAuth.instance.getUserData();
      if (userdata != null) {
        email = userdata['email'];
        name = userdata['name'];
        photourl = userdata['photourl'];
        DatabaseReference db = FirebaseDatabase.instance.reference().child("users");
        db
            .child("userdata.id")
            .set(({
              'email': email,
              'name': name,
              'photourl': photourl,
            }))
            .asStream();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(userEmailKey, email);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavScreen()));
      }
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: orange,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: orange,
        actions: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: width * 0.02),
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(blue)),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString(userEmailKey, "Skip");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavScreen()));
                  },
                  child: Text(
                    "Skip",
                    style: GoogleFonts.ptSans(fontSize: width * 0.04, fontWeight: FontWeight.bold),
                  )))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/logo.png", height: width * 0.55, width: width * 0.45),
            Text.rich(
              TextSpan(text: "Get ", style: GoogleFonts.ptSans(fontWeight: FontWeight.w500, fontSize: width * 0.07), children: [
                TextSpan(text: "Personalised News", style: GoogleFonts.ptSans(color: blue, fontWeight: FontWeight.bold, fontSize: width * 0.07)),
                const TextSpan(text: " and"),
                TextSpan(text: " Videos for you", style: GoogleFonts.ptSans(color: blue, fontWeight: FontWeight.bold, fontSize: width * 0.07)),
                const TextSpan(text: ", anytime anywhere")
              ]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: width * 0.1),
            Text(
              "Login with",
              textAlign: TextAlign.center,
              style: GoogleFonts.ptSans(fontWeight: FontWeight.w600, fontSize: width * 0.04),
            ),
            SizedBox(height: width * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: width * 0.25,
                  width: width * 0.25,
                  child: GestureDetector(
                    onTap: () {
                      _googleSignIn();
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const Interest()));
                    },
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: width * 0.2,
                        padding: EdgeInsets.all(width * 0.05),
                        child: SvgPicture.asset(
                          'assets/google.svg',
                          // color: Colors.white,
                          height: width * 0.15,
                          width: width * 0.15,
                        ),
                      ),
                    ),
                  ),
                ),
                /*SizedBox(width: width * 0.2),
                Container(
                  height: width * 0.25,
                  width: width * 0.25,
                  child: GestureDetector(
                    onTap: () {
                      _signInWithFacebook();
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Interest()));
                    },
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: width * 0.2,
                        padding: EdgeInsets.all(width * 0.05),
                        child: SvgPicture.asset(
                          'assets/facebook.svg',
                          // color: Color.fromRGBO(66, 103, 178, 1),
                          height: width * 0.1,
                          width: width * 0.1,
                          color: Color.fromRGBO(66, 103, 178, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.02),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
