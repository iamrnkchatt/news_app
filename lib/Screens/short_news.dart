import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scnews/Screens/news_plus_details.dart';

class ShortNews extends StatefulWidget {
  const ShortNews({Key? key}) : super(key: key);

  @override
  _ShortNewsState createState() => _ShortNewsState();
}

class _ShortNewsState extends State<ShortNews> {
  Map<String, dynamic> shortNews = {};

  @override
  void initState() {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("short-video");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          shortNews = jsonDecode(jsonEncode(event.snapshot.value));
          setState(() {

          });
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsPlusDetails(shortvideo: shortNews, initPos: 0, catName: "")));
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
    return NewsPlusDetails(shortvideo: shortNews, initPos: 0, catName: "");
  }
}
