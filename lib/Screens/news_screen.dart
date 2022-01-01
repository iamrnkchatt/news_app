import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scnews/Screens/livenewsslider_cat_widget.dart';
import 'package:scnews/Screens/livenewsslider_widget.dart';
import 'package:scnews/Screens/notification.dart';
import 'package:scnews/constant.dart';
import 'package:scnews/Screens/news_widget.dart';

class NewsScreen extends StatefulWidget {
  final String id;

  NewsScreen({Key? key, required this.id});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Map<String, dynamic> catNews = {};

  @override
  void initState() {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("news");
      Stream<DatabaseEvent> stream = ref.orderByChild("category").equalTo(widget.id).onValue;
      stream.listen((DatabaseEvent event) {
        try {
          catNews = jsonDecode(jsonEncode(event.snapshot.value));
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
    ScrollController _scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        leading: Text(""),
        leadingWidth: width * 0.001,
        title: Container(
          height: width * 0.2,
          width: width * 0.4,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/hehe.png"), fit: BoxFit.contain)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NotificationScreen())),
            child: Container(
              padding: EdgeInsets.only(right: width * 0.04),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
                size: width * 0.08,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: 0.0),
          child: Column(
            children: [
              SizedBox(height: width * 0.04),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                itemCount: catNews.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      height: height * 0.25,
                      child: LivenewssliderCetWidget(catNews[catNews.keys.elementAt(index)], catNews.keys.elementAt(index)),
                    );
                  } else {
                    return NewsWidget(catNews[catNews.keys.elementAt(index)], catNews.keys.elementAt(index));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
