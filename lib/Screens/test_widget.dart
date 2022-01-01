import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/news_screen.dart';
import 'package:scnews/constant.dart';

class MessageWidget extends StatelessWidget {
  final String image;
  final String name;
  final String catId;

  MessageWidget(this.image, this.name, this.catId);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewsScreen(id: catId)));
      },
      child: SizedBox(
        height: width * 0.05,
        width: width * 0.35,
        child: Card(
          elevation: 2,
          color: red,
          shadowColor: blue,
          child: Center(
            child: Text(
              name,
              style: GoogleFonts.ptSans(
                  color: Colors.white,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Text(
        //   name,
        //   style: TextStyle(color: Colors.black),
        // ),
      ),
    );
  }
}
