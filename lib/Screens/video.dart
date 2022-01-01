import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/home.dart';
import 'package:scnews/Screens/videodetails.dart';
import 'package:scnews/constant.dart';
import '../Models/video_dao.dart';
import '../Models/video_model.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:scnews/Screens/video_widget.dart';
import 'package:scnews/Screens/videoslider_widget.dart';

class Video extends StatefulWidget {
  final videoDao = VideoDao();

  Video({Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: width * 0.04),
            Text("Watch",
                textAlign: TextAlign.start,
                style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: width * 0.07)),
            SizedBox(height: width * 0.04),
            Container(
              width: width,
              child: FirebaseAnimatedList(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                query: widget.videoDao.getvideoQuery(),
                itemBuilder: (context, snapshot, animation, index) {
                  final json = snapshot.value as Map<dynamic, dynamic>;
                  final video = Videomodel.fromJson(json);
                  List totalItems = [];

                  return videoWidget(video.image, video.title, video.gallery,video.description);

                  // return Text(message.name);
                },
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     // Navigator.of(context).push(MaterialPageRoute(
            //     //     builder: (context) => const VideoDetails()));
            //   },
            //   child: WatchCard(width: width),
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trending Videos",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: width * 0.06,
                  ),
                ),
                /*Text("See all>>",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.ptSans(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: width * 0.04)),*/
              ],
            ),
            SizedBox(height: width * 0.04),
            Container(
              height: 300,
              width: width,
              child: FirebaseAnimatedList(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                query: widget.videoDao.getvideoQuery(),
                itemBuilder: (context, snapshot, animation, index) {
                  final json = snapshot.value as Map<dynamic, dynamic>;
                  final video = Videomodel.fromJson(json);
                  List totalItems = [];

                  return videosliderWidget(
                      video.image,video.gallery, video.title, video.description);

                  // return Text(message.name);
                },
              ),
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       PopularVideoTile(width: width),
            //       SizedBox(width: width * 0.04),
            //       PopularVideoTile(width: width),
            //       SizedBox(width: width * 0.04),
            //       PopularVideoTile(width: width),
            //     ],
            //   ),
            // ),
           /* Container(
              width: width,
              child: FirebaseAnimatedList(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                query: widget.videoDao.getvideoQuery(),
                itemBuilder: (context, snapshot, animation, index) {
                  final json = snapshot.value as Map<dynamic, dynamic>;
                  final video = Videomodel.fromJson(json);
                  List totalItems = [];

                  return videoWidget(video.image, video.title, video.gallery,video.description);

                  // return Text(message.name);
                },
              ),
            ),*/
          ],
        ),
      ),
    ));
  }
}

class WatchCard extends StatelessWidget {
  const WatchCard({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: width * 0.7,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: width * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage("assets/logo.png"),
                    fit: BoxFit.cover,
                  )),
              child: Center(
                  child: Icon(CupertinoIcons.play_circle,
                      color: Colors.white, size: width * 0.2)),
            ),
            SizedBox(height: width * 0.02),
            Text("TECHNOLOGY",
                style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontSize: width * 0.04)),
            Text(
              "Malik’s son-in-law sends legal notice to Fadnavis",
              style: GoogleFonts.ptSans(
                  fontWeight: FontWeight.bold, fontSize: width * 0.04),
            ),
            SizedBox(height: width * 0.015),
            Row(
              children: [
                Container(
                  height: width * 0.12,
                  width: width * 0.12,
                  decoration: BoxDecoration(
                      border: Border.all(color: blue),
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: const DecorationImage(
                          image: AssetImage("assets/logo.jpeg"))),
                ),
                SizedBox(width: width * 0.04),
                Row(
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
