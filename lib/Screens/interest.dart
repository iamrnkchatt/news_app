import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scnews/Screens/nav_screen.dart';
import 'package:scnews/constant.dart';

class Interest extends StatelessWidget {
  const Interest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: width * 0.02),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(blue)),
                  onPressed: () {},
                  child: Text(
                    "Skip",
                    style: GoogleFonts.ptSans(
                        fontSize: width * 0.04, fontWeight: FontWeight.bold),
                  )))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: width * 0.1),
            Image.asset(
              "assets/logo.jpeg",
              height: width * 0.3,
              width: width * 0.3,
            ),
            SizedBox(height: width * 0.04),
            Text(
              "CHOOSE INTEREST",
              style: GoogleFonts.ptSans(
                  fontWeight: FontWeight.bold, fontSize: width * 0.08),
            ),
            Text(
              "Choose 5 or more topic to start reading and saving articles",
              style: GoogleFonts.ptSans(
                  fontWeight: FontWeight.w400, fontSize: width * 0.045),
            ),
            SizedBox(height: width * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: width * 0.15,
                  width: width * 0.4,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    color: orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        height: width * 0.2,
                        child: Center(
                          child: Text(
                            "History",
                            style: GoogleFonts.ptSans(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: width * 0.05),
                          ),
                        )),
                  ),
                ),
                SizedBox(width: width * 0.04),
                Container(
                  height: width * 0.15,
                  width: width * 0.4,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        height: width * 0.2,
                        child: Center(
                          child: Text(
                            "History",
                            style: GoogleFonts.ptSans(
                                fontWeight: FontWeight.w400,
                                fontSize: width * 0.04),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: width * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: width * 0.15,
                  width: width * 0.4,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        height: width * 0.2,
                        child: Center(
                          child: Text(
                            "History",
                            style: GoogleFonts.ptSans(
                                fontWeight: FontWeight.w400,
                                fontSize: width * 0.04),
                          ),
                        )),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Container(
                  height: width * 0.15,
                  width: width * 0.4,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    color: orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        height: width * 0.2,
                        child: Center(
                          child: Text(
                            "History",
                            style: GoogleFonts.ptSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: width * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: width * 0.15,
                  width: width * 0.4,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        height: width * 0.2,
                        child: Center(
                          child: Text(
                            "History",
                            style: GoogleFonts.ptSans(
                                fontWeight: FontWeight.w400,
                                fontSize: width * 0.04),
                          ),
                        )),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Container(
                  height: width * 0.15,
                  width: width * 0.4,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        height: width * 0.2,
                        child: Center(
                          child: Text(
                            "History",
                            style: GoogleFonts.ptSans(
                                fontWeight: FontWeight.w400,
                                fontSize: width * 0.04),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: width * 0.04),
            Container(
              height: width * 0.1,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                      backgroundColor: MaterialStateProperty.all(blue)),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NavScreen()));
                  },
                  child: Text(
                    "DONE",
                    style: GoogleFonts.ptSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.05),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
