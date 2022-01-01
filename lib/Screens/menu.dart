import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/edit_profile.dart';
import 'package:scnews/Screens/login.dart';
import 'package:scnews/Screens/notification.dart';
import 'package:scnews/Screens/privacy_policy_screen.dart';
import 'package:scnews/Screens/sources.dart';
import 'package:scnews/Screens/terms_and_condition_screen.dart';
import 'package:scnews/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: width * 0.04),
          Text("Menu", textAlign: TextAlign.start, style: GoogleFonts.ptSans(fontWeight: FontWeight.w600, color: Colors.black, fontSize: width * 0.07)),
          SizedBox(height: width * 0.08),
          if (Constant.userEmail.isNotEmpty)
            SettingTile(
              width: width,
              icon: Icons.person,
              text: "My Profile",
              ontap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditProfile()));
              },
            )
          else
            SettingTile(
              width: width,
              icon: Icons.logout,
              text: "Sign In",
              ontap: () async {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route) => false);
              },
            ),
          const Divider(),
          SettingTile(
            width: width,
            icon: Icons.notifications,
            text: "Notifications",
            ontap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NotificationScreen()));
            },
          ),
          const Divider(),
          SettingTile(
            width: width,
            icon: Icons.source,
            text: "Sources",
            ontap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SourcesScreen()));
            },
          ),
          const Divider(),
          SettingTile(
            width: width,
            icon: Icons.shield_outlined,
            text: "Privacy Policy",
            ontap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
            },
          ),
          const Divider(),
          SettingTile(
            width: width,
            icon: CupertinoIcons.doc_on_clipboard,
            text: "Terms & Conditions",
            ontap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TermsandConditionScreen()));
            },
          ),
          const Divider(),
          if (Constant.userEmail.isNotEmpty)
            SettingTile(
              width: width,
              icon: Icons.logout,
              text: "Sign Out",
              ontap: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Constant.userEmail = "";
                Constant.userImage = "";
                Constant.userName = "";
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route) => false);
              },
            ),
          const Divider(),
        ],
      ),
    ));
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile({
    Key? key,
    required this.width,
    required this.icon,
    required this.ontap,
    required this.text,
  }) : super(key: key);

  final double width;
  final IconData icon;
  final String text;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0.0,
      onTap: () => ontap(),
      leading: Icon(
        icon,
        size: width * 0.065,
        color: Colors.black,
      ),
      title: Text(
        text,
        style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, color: Colors.black, fontSize: width * 0.045),
      ),
      trailing: Icon(
        CupertinoIcons.forward,
        color: Colors.grey,
        size: width * 0.06,
      ),
    );
  }
}
