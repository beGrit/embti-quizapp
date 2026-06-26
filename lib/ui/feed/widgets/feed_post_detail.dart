import 'package:flutter/material.dart';

class FeedPostDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FeedPostDetailState();
}

class FeedPostDetailState extends State<FeedPostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Center(child: Container(child: Text('Feed Post Detail'))),
    );
  }
}
