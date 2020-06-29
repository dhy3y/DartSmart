import 'package:DartSmart/newArticle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
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
                    'Dashboard',
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: FlatButton(
                          onPressed: () =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NewArticle())
                            ),
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: Column(
                              children: <Widget>[
                                Image.asset('assets/images/feed.png'),
                                Text(
                                  "New Entry",
                                  style: GoogleFonts.vt323(fontSize: 40),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: FlatButton(
                          onPressed: () => {},
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: Column(
                              children: <Widget>[
                                Image.asset('assets/images/login.png'),
                                Text(
                                  "My Articles",
                                  style: GoogleFonts.vt323(fontSize: 40),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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