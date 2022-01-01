import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/newsdetails.dart';
import 'package:scnews/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LivenewssliderCetWidget extends StatefulWidget {
  Map<String, dynamic> newsDetail;
  String newsId;

  LivenewssliderCetWidget(this.newsDetail, this.newsId);

  @override
  State<LivenewssliderCetWidget> createState() => _LivenewssliderCetWidgetState();
}

class _LivenewssliderCetWidgetState extends State<LivenewssliderCetWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewsDetails(
                  newsDetail: widget.newsDetail,
                  isLive: true,
                  newsId: widget.newsId,
                )));
      },
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${Constant.basePath}${widget.newsDetail['image']}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    widget.newsDetail['title'],
                    maxLines: 2,
                    style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, color: Colors.black, fontSize: width * 0.05),
                  ),
                ),
              ),
            )
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
    //           "${Constant.basePath}${image}"),
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
    //                           "${Constant.basePath}${image}"),
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
