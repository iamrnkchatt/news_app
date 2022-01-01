import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/newsdetails.dart';
import 'package:scnews/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LivenewssliderWidget extends StatefulWidget {
  Map<String, dynamic> newsDetail;
  String newsId;

  LivenewssliderWidget(this.newsDetail, this.newsId);

  @override
  State<LivenewssliderWidget> createState() => _LivenewssliderWidgetState();
}

class _LivenewssliderWidgetState extends State<LivenewssliderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsDetails(newsDetail: widget.newsDetail, newsId: widget.newsId, isLive: true)));
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage("${Constant.basePath}${widget.newsDetail['image']}"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 100,
                  height: 40,
                  padding: const EdgeInsets.only(left: 5, top: 8),
                  child: const Card(
                    elevation: 5,
                    color: blue,
                    child: Center(
                      child: Text(
                        "Top News",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.black45),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.newsDetail['title'],
                      style: GoogleFonts.ptSans(fontWeight: FontWeight.w600, color: orange, fontSize: width * 0.05),
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );

    // Container(
    //   width: width,
    //   // margin: const EdgeInsets.all(2.0),
    //   // padding: EdgeInsets.symmetric(horizontal: width * 0.02),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(8.0),
    //     image: DecorationImage(
    //       image: NetworkImage(
    //           "https://vedastechnocratspvtltd.com/scstnews/public/backend/image/gallery/${image}"),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(title,
    //             style: GoogleFonts.ptSans(
    //                 fontWeight: FontWeight.w600,
    //                 color: orange,
    //                 fontSize: width * 0.06)),
    //         Text("Lorem ipsum Lorem ipsum",
    //             style: GoogleFonts.ptSans(
    //                 fontWeight: FontWeight.w500,
    //                 color: Colors.white,
    //                 fontSize: width * 0.04)),
    //         ElevatedButton(
    //             style: ButtonStyle(
    //                 backgroundColor: MaterialStateProperty.all(blue)),
    //             onPressed: () {},
    //             child: const Text("Read More"))
    //       ]),
    // );

    // GestureDetector(
    //   onTap: () {
    //     // Navigator.of(context)
    //     //     .push(MaterialPageRoute(builder: (context) => const NewsDetails()));
    //   },
    //   child: Container(
    //     margin: const EdgeInsets.only(bottom: 10),
    //     child: Row(
    //       children: [
    //         Expanded(
    //             child: Container(
    //                 height: width * 0.2,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10),
    //                     image: DecorationImage(
    //                       image: NetworkImage(
    //                           "https://vedastechnocratspvtltd.com/scstnews/public/backend/image/gallery/${image}"),
    //                       fit: BoxFit.cover,
    //                     )),
    //                 margin: EdgeInsets.symmetric(horizontal: width * 0.02),
    //                 child: null)),
    //         Expanded(
    //           flex: 2,
    //           child: Column(
    //             children: [
    //               Text(
    //                 title,
    //                 style: GoogleFonts.ptSans(
    //                     fontWeight: FontWeight.bold, fontSize: width * 0.04),
    //               ),
    //               Row(
    //                 children: [
    //                   Text(
    //                     "John Doe",
    //                     style: GoogleFonts.ptSans(
    //                         color: Colors.grey, fontSize: width * 0.03),
    //                   ),
    //                   Text(
    //                     " . 16m ago",
    //                     style: GoogleFonts.ptSans(
    //                         color: Colors.grey, fontSize: width * 0.03),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
