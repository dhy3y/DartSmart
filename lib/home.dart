import 'package:DartSmart/Authentication/login.dart';
import 'package:DartSmart/home_feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//
//class Home extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: HomePage(),
//    );
//  }
//}
//
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Corona Times"),
//        backgroundColor: Colors.black,
//        actions: <Widget>[
//          FlatButton.icon(
//            onPressed: () {
//              Navigator.push(
//                context,
//                new MaterialPageRoute(builder: (context) => new Login()),
//              );
//            },
//            icon: const Icon(
//              Icons.person,
//              color: Colors.white,
//            ),
//            color: Colors.black,
//            label: const Text(
//              'Login!',
//              style: TextStyle(color: Colors.white),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}

class Home extends StatelessWidget {
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
                    'Home',
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
                                MaterialPageRoute(builder: (context) => HomeFeed())
                            ),
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: Column(
                              children: <Widget>[
                                Image.asset('assets/images/feed.png'),
                                Text(
                                  "Feed",
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
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login())
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: Column(
                              children: <Widget>[
                                Image.asset('assets/images/login.png'),
                                Text(
                                  "Login",
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
