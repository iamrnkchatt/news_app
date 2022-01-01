import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/newsdetails.dart';
import 'package:scnews/constant.dart';

class LivenewsWidget extends StatefulWidget {
  Map<String, dynamic> newsDetail;
  String newsId;

  LivenewsWidget(this.newsDetail, this.newsId);

  @override
  State<LivenewsWidget> createState() => _LivenewsWidgetState();
}

class _LivenewsWidgetState extends State<LivenewsWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsDetails(newsDetail: widget.newsDetail, isLive: true, newsId: widget.newsId)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
                child: Container(
              height: width * 0.2,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage("${Constant.basePath}${widget.newsDetail['image']}"), fit: BoxFit.cover)),
              margin: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: null,
            )),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.newsDetail['title'], style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, fontSize: width * 0.04)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset("assets/times_of_india.jpg",height: 20,width: 20,),
                        SizedBox(width: 4),
                        Text("Times of india", style: GoogleFonts.ptSans(fontSize: width * 0.035)),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );

    //Text(title);
    // return SizedBox(
    //   height: width * 0.05,
    //   width: width * 0.35,
    //   child: Card(
    //     elevation: 2,
    //     // color: blue,
    //     shadowColor: blue,
    //     child: Center(
    //       child: Text(
    //         title,
    //         style: GoogleFonts.ptSans(
    //             color: Colors.black,
    //             fontSize: width * 0.04,
    //             fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //   ),

    //   // Text(
    //   //   name,
    //   //   style: TextStyle(color: Colors.black),
    //   // ),
    // );
  }
}
