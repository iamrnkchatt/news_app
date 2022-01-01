import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Models/shortvideo.dart';
import 'package:scnews/Screens/videodetails_play.dart';
import 'package:scnews/constant.dart';

class NewsPlusDetails extends StatefulWidget {
  Map<String, dynamic> shortvideo = {};
  final String catName;
  final int initPos;

  NewsPlusDetails({Key? key, required this.shortvideo, required this.initPos, required this.catName}) : super(key: key);

  @override
  _NewsPlusDetailsState createState() => _NewsPlusDetailsState();
}

class _NewsPlusDetailsState extends State<NewsPlusDetails> {
  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    controller = PageController(initialPage: widget.initPos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          child: Container(
              child: PageView.builder(
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.shortvideo.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(height: height, width: width, child: VideoPlayerScreen(videoUrl: widget.shortvideo[widget.shortvideo.keys.elementAt(index)]['gallery'])),
                        Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: width * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.catName,
                                  style: GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: width * 0.04),
                                ),
                                SizedBox(height: width * 0.04),
                                Text(
                                  widget.shortvideo[widget.shortvideo.keys.elementAt(index)]['title'],
                                  style: GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: width * 0.06),
                                ),
                                SizedBox(height: width * 0.04),
                                Text.rich(
                                  TextSpan(
                                    text: widget.shortvideo[widget.shortvideo.keys.elementAt(index)]['description'],
                                    children: [TextSpan(text: "READ MORE", style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, color: Colors.white))],
                                  ),
                                  style: GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.w500, fontSize: width * 0.035),
                                ),
                                SizedBox(height: width * 0.04),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: width * 0.2),
                                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "SWIPE UP TO CHANGE",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: width * 0.04),
                              ],
                            ))
                      ],
                    );
                  }))),
    );
  }
}
