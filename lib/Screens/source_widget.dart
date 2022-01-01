import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/constant.dart';

class SourceWidget extends StatelessWidget {
  final String image;
  final String name;

  SourceWidget(this.image, this.name);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.7,
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
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
            image: DecorationImage(
              image: NetworkImage(
                  "${Constant.basePath}${image}"),
            ),
          ),
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
      ),
    );
  }
}
