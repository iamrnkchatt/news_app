import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/constant.dart';

class SourcepageWidget extends StatelessWidget {
  final String image;
  final String name;

  SourcepageWidget(this.image, this.name);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListTile(
      leading: Container(
        height: width * 0.2,
        width: width * 0.2,
        decoration: BoxDecoration(
            border: Border.all(color: blue),
            shape: BoxShape.circle,
            color: Colors.grey,
            image: DecorationImage(
              image: NetworkImage(
                  "${Constant.basePath}${image}"),
            )),
      ),
      title: Text(name,
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
