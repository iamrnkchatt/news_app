import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/constant.dart';

class NewsDetails extends StatefulWidget {
  Map<String, dynamic> newsDetail;
  String newsId;
  bool isLive;

  NewsDetails({Key? key, required this.newsDetail, required this.isLive, required this.newsId}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  Map<String, dynamic> scstNews = {};
  Map<String, dynamic> commentList = {};
  TextEditingController cmntController = TextEditingController();

  @override
  void initState() {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("news");
      Stream<DatabaseEvent> stream = ref.orderByChild("category").equalTo(widget.newsDetail['category']).onValue;
      stream.listen((DatabaseEvent event) {
        try {
          scstNews = jsonDecode(jsonEncode(event.snapshot.value));
          setState(() {});
        } on Exception catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("comments");
      Stream<DatabaseEvent> stream = ref.orderByChild("newsId").equalTo(widget.newsId).onValue;
      stream.listen((DatabaseEvent event) {
        try {
          commentList = jsonDecode(jsonEncode(event.snapshot.value));
          setState(() {});
        } on Exception catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: blue,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03),
                Row(
                  children: [
                    Container(
                      height: width * 0.12,
                      width: width * 0.12,
                      child: Image.asset(widget.isLive ? "assets/times_of_india.jpg" : "assets/logo_sqr.png"),
                    ),
                    SizedBox(width: width * 0.04),
                    Expanded(child: Text(widget.newsDetail['title'], style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, color: Colors.black, fontSize: width * 0.06))),
                  ],
                ),
                SizedBox(height: width * 0.04),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(widget.newsDetail['post_date'],
                      style: GoogleFonts.ptSans(
                          color: Colors.black,
                          fontSize: width * 0.04)),
                ),
                SizedBox(height: width * 0.04),
                Container(
                  height: width * 0.5,
                  width: width,
                  // margin: const EdgeInsets.all(2.0),
                  // padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage("${Constant.basePath}${widget.newsDetail['image']}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: null,
                ),
                SizedBox(height: width * 0.04),
                Html(data: widget.newsDetail['description']),
                SizedBox(height: width * 0.04),
                Text("Related Posts", textAlign: TextAlign.start, style: GoogleFonts.ptSans(fontWeight: FontWeight.w600, color: Colors.black, fontSize: width * 0.06)),
                if (scstNews.isNotEmpty)
                  for (int i = 0; i < scstNews.length; i++)
                    Column(
                      children: [
                        RelatedPostContainer(width: width, newsDetail: scstNews[scstNews.keys.elementAt(i)], newsId: scstNews.keys.elementAt(i)),
                        const Divider(),
                      ],
                    ),
                SizedBox(height: width * 0.05),
                Text("Comments", textAlign: TextAlign.start, style: GoogleFonts.ptSans(fontWeight: FontWeight.w600, color: Colors.black, fontSize: width * 0.06)),
                SizedBox(height: width * 0.05),
                if (commentList != null && commentList.isNotEmpty)
                  for (int i = 0; i < commentList.length; i++)
                    Column(
                      children: [
                        ListTile(
                          leading: Image.network(commentList[commentList.keys.elementAt(i)]['photourl']),
                          title: Text(commentList[commentList.keys.elementAt(i)]['name'],style: GoogleFonts.ptSans(color: Colors.black, fontSize: width * 0.04,fontWeight: FontWeight.bold)),
                          subtitle: Text(commentList[commentList.keys.elementAt(i)]['comment'],style: GoogleFonts.ptSans(color: Colors.black, fontSize: width * 0.04)),
                        ),
                        const Divider(),
                      ],
                    ),
                SizedBox(height: width * 0.2),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: Constant.userEmail.isNotEmpty ? width * 0.12 : 0,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: TextFormField(
          controller: cmntController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.message, color: Colors.grey, size: width * 0.08),
              suffixIcon: InkWell(
                onTap: () {
                  if (cmntController.text.trim().isNotEmpty) {
                    postComment();
                  }
                },
                child: Icon(Icons.check, color: Colors.black, size: width * 0.075),
              ),
              hintText: "Write Comment",
              hintStyle: GoogleFonts.ptSans(fontWeight: FontWeight.w500, color: Colors.grey)),
        ),
      ),
    );
  }

  void postComment() {
    DatabaseReference db = FirebaseDatabase.instance.reference().child("comments");
    db
        .push()
        .set(
          ({
            'email': Constant.userEmail,
            'photourl': Constant.userImage,
            'name': Constant.userName,
            'newsId': widget.newsId,
            'comment': cmntController.text.trim(),
          }),
        )
        .asStream();
    cmntController.clear();
    setState(() {});
  }
}

class RelatedPostContainer extends StatelessWidget {
  Map<String, dynamic> newsDetail;
  String newsId;

  RelatedPostContainer({Key? key, required this.width, required this.newsDetail, required this.newsId}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewsDetails(
                  newsDetail: newsDetail,
                  isLive: false,
                  newsId: newsId,
                )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: width * 0.04),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(newsDetail['title'], textAlign: TextAlign.start, style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, color: Colors.black, fontSize: width * 0.04)),
                ),
                Expanded(
                  child: Container(
                    height: width * 0.19,
                    width: width * 0.12,
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10), image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(Constant.basePath + newsDetail['image']))),
                  ),
                ),
              ],
            ),
            SizedBox(height: width * 0.04),
            /*Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "",
                  style: GoogleFonts.ptSans(color: Colors.black, fontWeight: FontWeight.bold, fontSize: width * 0.045),
                ),
                SizedBox(width: width * 0.01),
                Text(
                  " . 16m ago",
                  style: GoogleFonts.ptSans(color: Colors.grey, fontSize: width * 0.04),
                ),
                SizedBox(width: width * 0.04),
                Icon(Icons.message, color: Colors.grey, size: width * 0.04),
                SizedBox(width: width * 0.02),
                Text(
                  "37",
                  style: GoogleFonts.ptSans(color: Colors.grey, fontSize: width * 0.04),
                ),
              ],
            ),*/
          ],
        ),
      ),
    );
  }
}
