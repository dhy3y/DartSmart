import 'package:flutter/material.dart';

class ArticleDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8e4c9),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    "Coronavirus Update!".toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Subway',
                      fontSize: 35,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Image.asset('assets/images/divider.png'),
                  Text(
                    "Aliquip sunt occaecat pariatur esse adipisicing sunt deserunt idsunt pariatur cupidatat eu incididunt est eiusmod ad irure aute ut dolor tempor nulla pariatur ex fugiat ut quis adipisicing nostrud consequat ut duis proident. Aliquip sunt occaecat pariatur esse adipisicing sunt deserunt idsunt pariatur cupidatat eu incididunt est eiusmod ad irure aute ut dolor tempor nulla pariatur ex fugiat ut quis adipisicing nostrud consequat ut duis proident",
                    style: TextStyle(
                      fontFamily: 'Chenier',
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
