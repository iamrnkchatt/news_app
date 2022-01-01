import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/constant.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../Models/source_dao.dart';
import '../Models/source.dart';
import 'sourcepage_widget.dart';

class SourcesScreen extends StatefulWidget {
  final sourceDao = SourceDao();
  SourcesScreen({Key? key}) : super(key: key);

  @override
  State<SourcesScreen> createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScrollController _scrollController = ScrollController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: width * 0.02),
            Text("Sources",
                style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: width * 0.065)),
            SizedBox(height: width * 0.04),
            FirebaseAnimatedList(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              query: widget.sourceDao.getSourceQuery(),
              itemBuilder: (context, snapshot, animation, index) {
                final json = snapshot.value as Map<dynamic, dynamic>;
                final source = Source.fromJson(json);
                List totalItems = [];

                return SourcepageWidget(source.image, source.name);

                // return Text(message.name);
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class SourceTile extends StatelessWidget {
  const SourceTile({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: width * 0.2,
        width: width * 0.2,
        decoration: BoxDecoration(
            border: Border.all(color: blue),
            shape: BoxShape.circle,
            color: Colors.grey,
            image:
                const DecorationImage(image: AssetImage("assets/abplogo.png"))),
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
    );
  }
}
