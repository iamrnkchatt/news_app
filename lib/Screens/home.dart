import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/livenews_widget.dart';
import 'package:scnews/Screens/livenewsslider_widget.dart';
import 'package:scnews/Screens/news_plus_details.dart';
import 'package:scnews/Screens/news_widget.dart';
import 'package:scnews/Screens/newsdetails.dart';
import 'package:scnews/Screens/shortvideo_widget.dart';
import 'package:scnews/Screens/sources.dart';
import 'package:scnews/constant.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../Models/category_dao.dart';
import '../Models/category.dart';
import '../Models/livenews_dao.dart';
import '../Models/livenews.dart';
import '../Models/news_dao.dart';
import '../Models/news.dart';
import '../Models/shortvideo_dao.dart';
import '../Models/shortvideo.dart';
import 'test_widget.dart';
import '../Models/source_dao.dart';
import '../Models/source.dart';
import 'source_widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  final messageDao = MessageDao();
  final livenewsDao = LivenewsDao();
  final newsDao = NewsDao();
  final shortvideoDao = ShortvideoDao();
  final sourceDao = SourceDao();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Map<String, dynamic> shortNews = {};
  Map<String, dynamic> liveNews = {};
  Map<String, dynamic> scstNews = {};
  final ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
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
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("news");
      Stream<DatabaseEvent> stream = ref.onValue;
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
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: 0.0),
      child: Column(
        children: [
          SizedBox(height: width * 0.01),
          Container(
            height: width * 0.12,
            child: FirebaseAnimatedList(
              scrollDirection: Axis.horizontal,
              query: widget.messageDao.getMessageQuery(),
              itemBuilder: (context, snapshot, animation, index) {
                final json = snapshot.value as Map<dynamic, dynamic>;
                final message = Message.fromJson(json);
                return MessageWidget(
                    message.image, message.name, snapshot.key.toString());
                // return Text(message.name);
              },
            ),
          ),
          Expanded(
              flex: 9,
              child: SingleChildScrollView(
                child: Container(
                  // height: height,
                  width: width,
                  child: Column(
                    children: [
                      SizedBox(height: width * 0.04),
                      if (liveNews.isNotEmpty)
                        CarouselSlider(
                          items: [
                            for (int i = 0; i < liveNews.length; i++)
                              LivenewssliderWidget(
                                  liveNews[liveNews.keys.elementAt(i)],
                                  liveNews.keys.elementAt(i)),
                          ],
                          options: CarouselOptions(
                            height: height * 0.25,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1200),
                            viewportFraction: 0.95,
                          ),
                        ),
                      SizedBox(height: width * 0.04),
                      Container(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 8, right: 8),
                                child: Image.asset('assets/lightning.png',
                                    height: 20, color: red),
                              ),
                              Text("Latest News",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.ptSans(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: width * 0.06)),
                            ],
                          )),
                      SizedBox(height: width * 0.04),
                      if (liveNews.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          itemCount: liveNews.length,
                          itemBuilder: (context, index) {
                            return LivenewsWidget(
                                liveNews[liveNews.keys.elementAt(index)],
                                liveNews.keys.elementAt(index));
                          },
                        ),
                      SizedBox(height: width * 0.04),
                      const Divider(color: Colors.grey),
                      SizedBox(height: width * 0.04),
                      Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Image.asset(
                                    "assets/featured_news_image.png",
                                    color: red,
                                    height: 20),
                              ),
                              Text("Featured News",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.ptSans(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: width * 0.06)),
                            ],
                          )),
                      SizedBox(height: width * 0.04),
                      if (scstNews.isNotEmpty &&
                          liveNews.isNotEmpty &&
                          scstNews.length > 4 &&
                          liveNews.length > 4)
                        CarouselSlider(
                          items: [
                            for (int i = 0; i < 4; i++)
                              Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NewsDetails(
                                                              newsDetail: liveNews[
                                                                  liveNews.keys
                                                                      .elementAt(
                                                                          i)],
                                                              isLive: true,
                                                              newsId: liveNews
                                                                  .keys
                                                                  .elementAt(i),
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
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(Constant
                                                                    .basePath +
                                                                liveNews[liveNews
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]
                                                                    ['image']),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child:
                                                                    Container(
                                                                  width: 70,
                                                                  height: 35,
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      top: 8),
                                                                  child:
                                                                      const Card(
                                                                    elevation:
                                                                        5,
                                                                    color: blue,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Exclusive",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 12),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Center(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          width: width,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Colors
                                                                      .white),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Text(
                                                                liveNews[liveNews
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]
                                                                    ['title'],
                                                                maxLines: 2,
                                                                style: GoogleFonts.ptSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        width *
                                                                            0.04)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: width * 0.04),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NewsDetails(
                                                              newsDetail: scstNews[
                                                                  scstNews.keys
                                                                      .elementAt(
                                                                          i)],
                                                              isLive: false,
                                                              newsId: scstNews
                                                                  .keys
                                                                  .elementAt(i),
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
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(Constant
                                                                    .basePath +
                                                                scstNews[scstNews
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]
                                                                    ['image']),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child:
                                                                    Container(
                                                                  width: 70,
                                                                  height: 35,
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      top: 8),
                                                                  child:
                                                                      const Card(
                                                                    elevation:
                                                                        5,
                                                                    color: blue,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Exclusive",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 12),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Center(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          width: width,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Colors
                                                                      .white),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: Text(
                                                                scstNews[scstNews
                                                                        .keys
                                                                        .elementAt(
                                                                            i)]
                                                                    ['title'],
                                                                maxLines: 3,
                                                                style: GoogleFonts.ptSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        width *
                                                                            0.04)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                          options: CarouselOptions(
                            height: height * 0.25,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1200),
                            viewportFraction: 0.95,
                          ),
                        ),
                      SizedBox(height: width * 0.04),
                      const Divider(color: Colors.grey),
                      SizedBox(height: width * 0.04),
                      if (scstNews.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          itemCount: scstNews.length,
                          itemBuilder: (context, i) {
                            return NewsWidget(
                                scstNews[scstNews.keys.elementAt(i)],
                                scstNews.keys.elementAt(i));
                          },
                        ),
                      SizedBox(height: width * 0.04),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Image.asset('assets/sources.png',
                                color: red, height: 20),
                          ),
                          Text("Sources",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.ptSans(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: width * 0.06)),
                          Expanded(child: Container()),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SourcesScreen()));
                              },
                              child: Text("See all>>",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.ptSans(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      fontSize: width * 0.04))),
                        ],
                      ),
                      SizedBox(height: width * 0.04),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              child: FirebaseAnimatedList(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                query: widget.sourceDao.getSourceQuery(),
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  final json =
                                      snapshot.value as Map<dynamic, dynamic>;
                                  final source = Source.fromJson(json);
                                  return SourceWidget(
                                      source.image, source.name);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: width * 0.04),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Image.asset("assets/recents.png",
                                color: red, height: 20),
                          ),
                          Text("Recent Shorts",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.ptSans(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: width * 0.06)),
                          Expanded(child: Container()),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NewsPlusDetails(
                                        shortvideo: shortNews,
                                        initPos: 0,
                                        catName: "")));
                              },
                              child: Text("See all>>",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.ptSans(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      fontSize: width * 0.04))),
                        ],
                      ),
                      SizedBox(height: width * 0.04),
                      if (shortNews.isNotEmpty)
                        Container(
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsPlusDetails(
                                                    shortvideo: shortNews,
                                                    initPos: index,
                                                    catName: "")));
                                  },
                                  child: ShortvideoWidget(shortNews[
                                      shortNews.keys.elementAt(index)]));
                            },
                          ),
                        ),
                      SizedBox(height: width * 0.04),
                    ],
                  ),
                ),
              ))
        ],
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

  Container _sourceTile(double width) {
    return Container(
      width: width * 0.7,
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Container(
          height: width * 0.2,
          width: width * 0.2,
          decoration: BoxDecoration(
              border: Border.all(color: blue),
              shape: BoxShape.circle,
              color: Colors.grey,
              image: const DecorationImage(
                  image: AssetImage("assets/abplogo.png"))),
        ),
        title: Text("ABP NEWS",
            style: GoogleFonts.ptSans(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: width * 0.045)),
        subtitle: Text(
          "South Carolina",
          style: GoogleFonts.ptSans(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: width * 0.045),
        ),
      ),
    );
  }
}

class NewsSlider extends StatelessWidget {
  const NewsSlider({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Container(
          width: width,
          // margin: const EdgeInsets.all(2.0),
          // padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: const DecorationImage(
              image: AssetImage("assets/slider1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lorem ipsum",
                    style: GoogleFonts.ptSans(
                        fontWeight: FontWeight.w600,
                        color: orange,
                        fontSize: width * 0.06)),
                Text("Lorem ipsum Lorem ipsum",
                    style: GoogleFonts.ptSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: width * 0.04)),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blue)),
                    onPressed: () {},
                    child: const Text("Read More"))
              ]),
        ),
        Container(
          width: width,
          // margin: const EdgeInsets.all(2.0),
          // padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: const DecorationImage(
              image: AssetImage("assets/slider1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lorem ipsum",
                    style: GoogleFonts.ptSans(
                        fontWeight: FontWeight.w600,
                        color: orange,
                        fontSize: width * 0.06)),
                Text("Lorem ipsum Lorem ipsum",
                    style: GoogleFonts.ptSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: width * 0.04)),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blue)),
                    onPressed: () {},
                    child: const Text("Read More"))
              ]),
        ),
        Container(
          width: width,
          // margin: const EdgeInsets.all(2.0),
          // padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: const DecorationImage(
              image: AssetImage("assets/slider1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lorem ipsum",
                    style: GoogleFonts.ptSans(
                        fontWeight: FontWeight.w600,
                        color: orange,
                        fontSize: width * 0.06)),
                Text("Lorem ipsum Lorem ipsum",
                    style: GoogleFonts.ptSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: width * 0.04)),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blue)),
                    onPressed: () {},
                    child: const Text("Read More"))
              ]),
        ),
      ],
      options: CarouselOptions(
        height: height * 0.25,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1200),
        viewportFraction: 0.95,
      ),
    );
  }
}

class PopularAuthorTile extends StatelessWidget {
  const PopularAuthorTile({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.2,
      width: width * 0.5,
      decoration: BoxDecoration(
          color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: width * 0.15,
            width: width * 0.15,
            decoration: BoxDecoration(
                border: Border.all(color: blue),
                shape: BoxShape.circle,
                color: Colors.grey,
                image: const DecorationImage(
                    image: AssetImage("assets/yash.jpeg"))),
          ),
          SizedBox(width: width * 0.04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "John Doe",
                style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.bold, fontSize: width * 0.045),
              ),
              Text(
                "Los Angeles",
                style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: width * 0.04),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PopularVideoTile extends StatelessWidget {
  const PopularVideoTile({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.7,
      width: width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/comp.png",
                height: width * 0.4,
                width: width * 0.6,
              ),
              Center(
                  child: Icon(CupertinoIcons.play_circle,
                      color: Colors.white, size: width * 0.2)),
            ],
          ),
          SizedBox(height: width * 0.01),
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
          SizedBox(height: width * 0.01),
          Row(
            children: [
              Container(
                height: width * 0.1,
                width: width * 0.1,
                decoration: BoxDecoration(
                    border: Border.all(color: blue),
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: const DecorationImage(
                        image: AssetImage("assets/yash.jpeg"))),
              ),
              SizedBox(width: width * 0.04),
              Row(
                children: [
                  Text(
                    "John Doe",
                    style: GoogleFonts.ptSans(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04),
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
    );
  }
}

class TopicContainer extends StatelessWidget {
  const TopicContainer({
    Key? key,
    required this.width,
    required this.text,
    required this.isSelected,
  }) : super(key: key);

  final double width;
  final String text;

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.1,
      width: width * 0.3,
      decoration: BoxDecoration(
          color: isSelected == true ? blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5)),
      child: Center(
          child: Text(
        text,
        style: GoogleFonts.ptSans(
            fontWeight: FontWeight.bold,
            fontSize: width * 0.04,
            color: isSelected == true ? Colors.white : Colors.grey),
      )),
    );
  }
}
