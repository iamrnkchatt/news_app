import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/videodetails.dart';
import 'package:scnews/constant.dart';

class videoWidget extends StatefulWidget {
  final String image;
  final String title;
  final String video;
  final String description;

  videoWidget(this.image, this.title, this.video, this.description);

  @override
  State<videoWidget> createState() => _videoWidgetState();
}

class _videoWidgetState extends State<videoWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VideoDetails(
                  image: widget.image,
                  title: widget.title,
                  video: widget.video,
                  description: widget.description,
                )));
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: width * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage("${Constant.basePath}${widget.image}"),
                    fit: BoxFit.cover,
                  )),
              child: Center(child: Icon(CupertinoIcons.play_circle, color: Colors.white, size: width * 0.2)),
            ),
            SizedBox(height: width * 0.02),
            /*Text("TECHNOLOGY",
                style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontSize: width * 0.04)),*/

            SizedBox(height: width * 0.015),
            Row(
              children: [
                Container(
                  height: width * 0.12,
                  width: width * 0.12,
                  decoration: BoxDecoration(border: Border.all(color: blue), shape: BoxShape.circle, color: Colors.grey, image: const DecorationImage(image: AssetImage("assets/logo.jpeg"))),
                ),
                SizedBox(width: width * 0.04),
                Expanded(
                  child: Text(
                    widget.title,
                    style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, fontSize: width * 0.04),
                  ),
                ),
                /*Row(
                  children: [
                    Text(
                      "",
                      style: GoogleFonts.ptSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.045),
                    ),
                    SizedBox(width: width * 0.01),
                    Text(
                      " . 16m ago",
                      style: GoogleFonts.ptSans(
                          color: Colors.grey, fontSize: width * 0.04),
                    ),
                  ],
                ),*/
              ],
            ),
            SizedBox(height: width * 0.1),
          ],
        ),
      ),
    );
  }
}
