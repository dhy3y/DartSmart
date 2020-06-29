import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDetail extends StatefulWidget {
  final DocumentSnapshot article;

  ArticleDetail({this.article});

  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: 40,
                  child: Text(
                    'Article',
                    style: GoogleFonts.vt323(fontSize: 40),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Divider(thickness: 2, color: Colors.black,),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/atricle_back.png"),
                  fit: BoxFit.fill,
                ),
                //border: Border.all(color: Colors.black, width: 5),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height/1.2,
                child: Container(
                    height: MediaQuery.of(context).size.height/1.5,
                    margin:
                        EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 100,),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            widget.article.data['title'].toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Subway',
                              fontSize: 35,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '(by ${widget.article.data['name']})',
                            style: TextStyle(
                              fontFamily: 'Subway',
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '[${widget.article.data['occupation']}]',
                            style: TextStyle(
                              fontFamily: 'Chenier',
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Image.asset('assets/images/divider.png'),
                          Text(
                            widget.article.data['description'],
                            style: TextStyle(
                              fontFamily: 'Chenier',
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
