import 'package:flutter/material.dart';
// import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class Shortvideotiktok extends StatefulWidget {
  const Shortvideotiktok({Key? key}) : super(key: key);

  @override
  State<Shortvideotiktok> createState() => _ShortvideotiktokState();
}

class _ShortvideotiktokState extends State<Shortvideotiktok> {
  final List<Color> colors = <Color>[
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container()/*TikTokStyleFullPageScroller(
        contentSize: colors.length,
        swipePositionThreshold: 0.2,
        // ^ the fraction of the screen needed to scroll
        swipeVelocityThreshold: 2000,
        // ^ the velocity threshold for smaller scrolls
        animationDuration: const Duration(milliseconds: 300),
        // ^ how long the animation will take
        onScrollEvent: _handleCallbackEvent,
        // ^ registering our own function to listen to page changes
        builder: (BuildContext context, int index) {
          return Container(
            color: colors[index],
            child: Center(
              child: Text(
                '$index',
                key: Key('$index-text'),
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          );
        },
      )*/,
    );
  }

  /*void _handleCallbackEvent(ScrollEventType type, {int? currentIndex}) {
    print(
        "Scroll callback received with data: {type: $type, and index: ${currentIndex ?? 'not given'}}");
  }*/
}
