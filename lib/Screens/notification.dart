import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Models/livenews_dao.dart';
import 'package:scnews/constant.dart';
import 'dart:math';

import 'livenews_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Map<String, dynamic> liveNews = {};

  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("live_news");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          liveNews = jsonDecode(jsonEncode(event.snapshot.value));
          setState(() {});
        } on Exception catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.04),
            child: Icon(
              Icons.more_horiz,
              color: Colors.black,
              size: width * 0.08,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: width * 0.02),
            Text("Notifications", style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, color: Colors.black, fontSize: width * 0.065)),
            SizedBox(height: width * 0.04),
            if (liveNews.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: min(liveNews.length, 10),
                  itemBuilder: (context, index) {
                    return LivenewsWidget(liveNews[liveNews.keys.elementAt(index)], liveNews.keys.elementAt(index));
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: width * 0.12,
        width: width * 0.12,
        decoration: BoxDecoration(border: Border.all(color: blue), shape: BoxShape.circle, color: Colors.grey, image: const DecorationImage(image: AssetImage("assets/yash.jpeg"))),
      ),
      title: Text("Malik’s son-in-law sends legal noti…", style: GoogleFonts.ptSans(fontWeight: FontWeight.bold, color: Colors.black, fontSize: width * 0.045)),
      subtitle: Row(
        children: [
          Text(
            " ",
            style: GoogleFonts.ptSans(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: width * 0.035),
          ),
          SizedBox(width: width * 0.01),
          Text(
            " ",
            style: GoogleFonts.ptSans(color: Colors.grey, fontSize: width * 0.035),
          ),
        ],
      ),
      trailing: Container(
        height: width * 0.15,
        width: width * 0.15,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey, image: const DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/person.png"))),
      ),
    );
  }
}
