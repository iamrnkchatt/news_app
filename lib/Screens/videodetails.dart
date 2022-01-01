import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/videodetails_play.dart';
import 'package:scnews/constant.dart';

class VideoDetails extends StatefulWidget {
  final String image;
  final String title;
  final String video;
  final String description;

  const VideoDetails({Key? key, required this.image, required this.title, required this.video, required this.description}) : super(key: key);

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          /*Padding(
            padding: EdgeInsets.only(right: width * 0.04),
            child: Icon(
              Icons.more_horiz,
              color: Colors.black,
              size: width * 0.08,
            ),
          )*/
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoUrl: widget.video)));
              },
              child: Container(
                height: width * 0.6,
                width: width,
                // margin: const EdgeInsets.all(2.0),
                // padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage("${Constant.basePath}${widget.image}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Icon(
                    CupertinoIcons.play_circle,
                    color: Colors.white,
                    size: width * 0.2,
                  ),
                ),
              ),
            ),
            SizedBox(height: width * 0.04),
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("TECHNOLOGY", style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: width * 0.04)),
                  SizedBox(height: width * 0.02),

                  SizedBox(height: width * 0.04),
                  Row(
                    children: [
                      Container(
                        height: width * 0.12,
                        width: width * 0.12,
                        decoration: BoxDecoration(border: Border.all(color: blue), shape: BoxShape.circle, color: Colors.grey, image: const DecorationImage(image: AssetImage("assets/logo.jpeg"))),
                      ),
                      SizedBox(width: width * 0.04),
                      Expanded(child: Text(widget.title, style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, color: Colors.black, fontSize: width * 0.07)))
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
                  SizedBox(height: width * 0.04),
                  const Divider(),
                  Html(data: widget.description),
                  SizedBox(height: width * 0.04),
                  // const Divider(thickness: 2),
                  // Text(
                  //   "Up Next",
                  //   style: GoogleFonts.ptSans(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: width * 0.045),
                  // ),
                  // SizedBox(height: width * 0.04),
                  // Container(
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //           child: Container(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Stack(
                  //           children: [
                  //             Image.asset(
                  //               "assets/person.png",
                  //               height: width * 0.2,
                  //               fit: BoxFit.contain,
                  //             ),
                  //             Positioned(
                  //               right: 10,
                  //               bottom: 10,
                  //               child: Container(
                  //                 height: width * 0.05,
                  //                 width: width * 0.1,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.black38,
                  //                     borderRadius: BorderRadius.circular(5)),
                  //                 child: Center(
                  //                     child: Text(
                  //                   "10:05",
                  //                   style: GoogleFonts.ptSans(
                  //                       fontWeight: FontWeight.bold,
                  //                       color: Colors.white),
                  //                 )),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       )),
                  //       Expanded(
                  //         flex: 2,
                  //         child: Column(
                  //           children: [
                  //             Text(
                  //               "Malik’s son-in-law sends legal notice to Fadnavis",
                  //               style: GoogleFonts.ptSans(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: width * 0.04),
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Text(
                  //                   "John Doe",
                  //                   style: GoogleFonts.ptSans(
                  //                       color: Colors.grey,
                  //                       fontSize: width * 0.03),
                  //                 ),
                  //                 Text(
                  //                   " . 16m ago",
                  //                   style: GoogleFonts.ptSans(
                  //                       color: Colors.grey,
                  //                       fontSize: width * 0.03),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Divider(),
                  // Container(
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //           child: Container(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Stack(
                  //           children: [
                  //             Image.asset(
                  //               "assets/person.png",
                  //               height: width * 0.2,
                  //               fit: BoxFit.contain,
                  //             ),
                  //             Positioned(
                  //               right: 10,
                  //               bottom: 10,
                  //               child: Container(
                  //                 height: width * 0.05,
                  //                 width: width * 0.1,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.black38,
                  //                     borderRadius: BorderRadius.circular(5)),
                  //                 child: Center(
                  //                     child: Text(
                  //                   "10:05",
                  //                   style: GoogleFonts.ptSans(
                  //                       fontWeight: FontWeight.bold,
                  //                       color: Colors.white),
                  //                 )),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       )),
                  //       Expanded(
                  //         flex: 2,
                  //         child: Column(
                  //           children: [
                  //             Text(
                  //               "Malik’s son-in-law sends legal notice to Fadnavis",
                  //               style: GoogleFonts.ptSans(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: width * 0.04),
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Text(
                  //                   "John Doe",
                  //                   style: GoogleFonts.ptSans(
                  //                       color: Colors.grey,
                  //                       fontSize: width * 0.03),
                  //                 ),
                  //                 Text(
                  //                   " . 16m ago",
                  //                   style: GoogleFonts.ptSans(
                  //                       color: Colors.grey,
                  //                       fontSize: width * 0.03),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: width * 0.04),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
