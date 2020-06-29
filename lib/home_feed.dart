import 'package:DartSmart/article_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class HomeFeed extends StatefulWidget {
  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {

  Future _data;

  Future getArticles() async {
    var fireStore = Firestore.instance;
    QuerySnapshot qn = await fireStore.collection("articles").getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    super.initState();

    _data = getArticles();
  }

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
                  width: MediaQuery.of(context).size.width / 2.75,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: 40,
                  child: Text(
                    'Feed',
                    style: GoogleFonts.vt323(fontSize: 40),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.75,
                  child: Image.asset(
                    'assets/images/title-lines.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Divider(thickness: 2, color: Colors.black,),
            Expanded(
              child: Container(
                child: FutureBuilder(
                    future: _data,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading..."),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
//                              return ListTile(
//                                title: Text(snapshot.data[index].data['title']),
//                              );
                              return Container(
                                padding: EdgeInsets.all(5.0),
                                child: Card(
                                  color: Colors.grey[300],
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ArticleDetail(
                                                  article: snapshot.data[index],
                                                ))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[index].data['title'],
                                            style:
                                                GoogleFonts.vt323(fontSize: 30),
                                          ),
                                          Text(
                                            'By ${snapshot.data[index].data['name']} [${snapshot.data[index].data['occupation']}]',
                                            style:
                                                GoogleFonts.vt323(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  elevation: 5,
                                ),
                              );
                            });
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
