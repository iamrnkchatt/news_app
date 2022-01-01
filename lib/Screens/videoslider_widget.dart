import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/videodetails.dart';
import 'package:scnews/constant.dart';

class videosliderWidget extends StatelessWidget {
  final String image;
  final String video;
  final String title;
  final String description;

  videosliderWidget(this.image, this.video, this.title, this.description);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoDetails(image: image, title: title, video: video, description: description)));
      },
      child: Container(
        height: width * 0.7,
        width: width * 0.6,
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  "${Constant.basePath}$image",
                  height: width * 0.4,
                  width: width * 0.6,
                ),
                Center(child: Icon(CupertinoIcons.play_circle, color: Colors.white, size: width * 0.2)),
              ],
            ),
            SizedBox(height: width * 0.01),
            /*Text("TECHNOLOGY",
                style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontSize: width * 0.04)),*/

            SizedBox(height: width * 0.01),
            Row(
              children: [
                Container(
                  height: width * 0.1,
                  width: width * 0.1,
                  decoration: BoxDecoration(border: Border.all(color: blue), shape: BoxShape.circle, color: Colors.grey, image: const DecorationImage(image: AssetImage("assets/logo.jpeg"))),
                ),
                SizedBox(width: width * 0.04),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, fontSize: width * 0.04),
                    maxLines: 3,
                  ),
                ),
                /*Row(
                  children: [
                    Text(
                      "John Doe",
                      style: GoogleFonts.ptSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04),
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
            )
          ],
        ),
      ),
    );
  }
}
