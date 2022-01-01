import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/newsdetails.dart';
import 'package:scnews/constant.dart';

class NewsWidget extends StatefulWidget {
  Map<String, dynamic> newsDetail;
  String newsId;

  NewsWidget(this.newsDetail, this.newsId);

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewsDetails(
                  newsDetail: widget.newsDetail,
                  isLive: false,
                  newsId: widget.newsId,
                )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
                child: Container(
                    height: width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage("${Constant.basePath}${widget.newsDetail['image']}"),
                          fit: BoxFit.cover,
                        )),
                    margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: null)),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(widget.newsDetail['title'], style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, fontSize: width * 0.04)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset("assets/logo_sqr.png", width: 20, height: 20),
                        SizedBox(width: 4),
                        Text("SC/ST news", style: GoogleFonts.ptSans(fontSize: width * 0.035)),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
