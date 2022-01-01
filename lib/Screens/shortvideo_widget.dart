import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Models/shortvideo.dart';
import 'package:scnews/Screens/news_plus_details.dart';
import 'package:scnews/Screens/shortvideo_tiktokscreen.dart';
import 'package:scnews/constant.dart';

class ShortvideoWidget extends StatelessWidget {
  Map<String, dynamic> shortvideo = {};

  ShortvideoWidget(this.shortvideo);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: width * 0.5,
      width: width * 0.35,
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage("${Constant.basePath}${shortvideo['image']}"), fit: BoxFit.cover, isAntiAlias: true), color: Colors.green),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: width * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Text(shortvideo['title'], textAlign: TextAlign.start, style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, color: Colors.white, fontSize: width * 0.035)),
          ),
          SizedBox(height: width * 0.04),
        ],
      ),
    );
  }
}
