import 'package:DartSmart/login.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Corona Times"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new Login()),
              );
            },
            icon: const Icon(Icons.person),
            label: const Text('Login!'),
          ),
        ],
      ),
    );
  }
}
