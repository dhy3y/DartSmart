import 'package:DartSmart/article_detail.dart';
import 'package:DartSmart/home.dart';
import 'package:DartSmart/home_feed.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
