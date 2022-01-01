import 'package:flutter/material.dart';
import 'package:scnews/Screens/notification.dart';
import 'package:scnews/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsandConditionScreen extends StatefulWidget {
  const TermsandConditionScreen({Key? key}) : super(key: key);

  @override
  _TermsandConditionScreenState createState() =>
      _TermsandConditionScreenState();
}

class _TermsandConditionScreenState extends State<TermsandConditionScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: orange,
          leading: Text(""),
          leadingWidth: width * 0.001,
          title: Container(
            height: width * 0.2,
            width: width * 0.4,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/hehe.png"), fit: BoxFit.contain)),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationScreen())),
              child: Container(
                padding: EdgeInsets.only(right: width * 0.04),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: width * 0.08,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Terms & Conditions',
                  style: GoogleFonts.ptSans(
                      fontWeight: FontWeight.w600,
                      color: orange,
                      fontSize: width * 0.06),
                ),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  style: GoogleFonts.ptSans(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: width * 0.04),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  style: GoogleFonts.ptSans(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: width * 0.04),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  style: GoogleFonts.ptSans(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: width * 0.04),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
