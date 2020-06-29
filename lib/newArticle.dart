import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ArticleEntry(),
    );
  }
}

class ArticleEntry extends StatefulWidget {
  @override
  _ArticleEntryState createState() => _ArticleEntryState();
}

class _ArticleEntryState extends State<ArticleEntry> {

  String name, title, description;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.8,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: 40,
                  child: Text(
                    'New Entry',
                    style: GoogleFonts.vt323(fontSize: 40),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.8,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              style: GoogleFonts.vt323(fontSize: 20),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Fullname',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              textAlign: TextAlign.left,
              onChanged: (text) {
                this.name = text;
              },
            ),
            SizedBox(height: 10),
            TextField(
              style: GoogleFonts.vt323(fontSize: 20),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Occupation',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              textAlign: TextAlign.left,
              onChanged: (text) {
                this.title = text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
