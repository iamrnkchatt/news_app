import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/news_plus_details.dart';
import '../Models/shortvideo_dao.dart';
import '../Models/shortvideo.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:scnews/Screens/shortvideo_widget.dart';

class NewsPlus extends StatefulWidget {
  NewsPlus({Key? key}) : super(key: key);

  @override
  State<NewsPlus> createState() => _NewsPlusState();
}

class _NewsPlusState extends State<NewsPlus> {
  ScrollController _scrollController = ScrollController();
  Map<String, dynamic> category = {};
  Map<String, dynamic> shortNews = {};

  @override
  void initState() {
    getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            itemCount: category.length,
            itemBuilder: (context, index) {
              return CategoryUI(
                  shortNews: shortNews, category: category, pos: index);
            }),
      ),
    ));
  }

  Container _newsPlusShortCard(double width) {
    return Container(
      height: width * 0.5,
      width: width * 0.35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage("assets/person2.png"),
            fit: BoxFit.cover,
            isAntiAlias: true,
          ),
          color: Colors.green),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: width * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Text("Big technology has a strong first quarter",
                textAlign: TextAlign.start,
                style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: width * 0.035)),
          ),
          SizedBox(height: width * 0.04),
        ],
      ),
    );
  }

  void getCategoryData() {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("category");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          category = jsonDecode(jsonEncode(event.snapshot.value));
          getNewsData();
        } on Exception catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void getNewsData() {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("short-video");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          shortNews = jsonDecode(jsonEncode(event.snapshot.value));
          setState(() {});
        } on Exception catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

class CategoryUI extends StatefulWidget {
  final Map<String, dynamic> category;
  final Map<String, dynamic> shortNews;
  final int pos;

  CategoryUI(
      {required this.shortNews, required this.category, required this.pos});

  @override
  State<CategoryUI> createState() => _CategoryUIState();
}

class _CategoryUIState extends State<CategoryUI> {
  ScrollController _scrollController = ScrollController();
  Map<String, dynamic> shortNews = {};

  @override
  void initState() {
    for (int i = 0; i < widget.shortNews.length; i++) {
      if (widget.shortNews[widget.shortNews.keys.elementAt(i)]['category'] ==
          widget.category.keys.elementAt(widget.pos)) {
        shortNews.addAll({
          widget.shortNews.keys.elementAt(i):
              widget.shortNews[widget.shortNews.keys.elementAt(i)]
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: width * 0.04),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Text(
              widget.category[widget.category.keys.elementAt(widget.pos)]
                  ['name'],
              textAlign: TextAlign.start,
              style: GoogleFonts.ptSans(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: width * 0.06)),
        ),
        SizedBox(height: width * 0.04),
        if (shortNews.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: width * 0.04),
            child: Container(
              height: 200,
              padding: EdgeInsets.only(left: width * 0.04),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: shortNews.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewsPlusDetails(
                                shortvideo: shortNews,
                                initPos: index,
                                catName: widget.category[widget.category.keys
                                    .elementAt(widget.pos)]['name'])));
                      },
                      child: ShortvideoWidget(
                          shortNews[shortNews.keys.elementAt(index)]));
                },
              ),
            ),
          ),
        SizedBox(height: width * 0.02),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
