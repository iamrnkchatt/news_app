import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scnews/Screens/home.dart';
import 'package:scnews/Screens/newsplus.dart';
import 'package:scnews/Screens/notification.dart';
import 'package:scnews/Screens/menu.dart';
import 'package:scnews/Screens/short_news.dart';
import 'package:scnews/Screens/video.dart';
import 'package:scnews/constant.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _page = 0;
  final screens = [
    Home(),
    ShortNews(),
    Video(),
    Menu(),
  ];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      // endDrawer: Drawer(),
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
      body: screens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        color: blue,
        buttonBackgroundColor: red,
        height: height * 0.08,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
        index: 0,
        items: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.house_fill,
                size: width * 0.07,
                color: Colors.white,
              ),
              Text(
                "Home",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: width * 0.025,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.news_solid,
                size: width * 0.07,
                color: Colors.white,
              ),
              Text(
                "Shorts",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: width * 0.025,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.video_camera,
                size: width * 0.07,
                color: Colors.white,
              ),
              Text(
                "Video",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: width * 0.025,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          GestureDetector(
            // onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  size: width * 0.07,
                  color: Colors.white,
                ),
                Text(
                  "Menu",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: width * 0.025,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
