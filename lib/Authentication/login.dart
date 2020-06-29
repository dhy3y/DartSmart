import 'package:DartSmart/Dashboard.dart';
import 'package:DartSmart/article.dart';
import 'package:DartSmart/home.dart';
import 'package:DartSmart/home_feed.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNo, smsCode, verificationId, message;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    setState(() {
      if (user != null) {
        message = 'Successfully signed in uid: ' + user.uid;
      } else {
        message = 'Sign in failed!';
      }
    });
  }

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed in!');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential credential) {
      print('Verified!');
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new Dashboard()),
      );
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text(
              'Enter OTP',
              style: GoogleFonts.vt323(fontSize: 25),
            ),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text(
                  'Done!',
                  style: GoogleFonts.vt323(fontSize: 25, color: Colors.black),
                ),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Dashboard()),
                      );
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              ),
            ],
          );
        });
  }

  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
//      appBar: new AppBar(
//        title: new Text('Authentication'),
//        backgroundColor: Colors.black,
//        leading: IconButton(
//          icon:const Icon(Icons.arrow_back_ios),
//          onPressed: () {
//            Navigator.push(
//              context,
//              new MaterialPageRoute(builder: (context) => new Home()),
//            );
//          },
//        )
//      ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
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
                    'Login',
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
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      height: 200,
                      child: Image.asset('assets/images/phone_logo.png'),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      style: GoogleFonts.vt323(fontSize: 20),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Unique ID',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.vt323(fontSize: 20),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter phone number and country code',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          )),
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        this.phoneNo = value;
                      },
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        setState(() {
                          _pressed = true;
                          print(_pressed);
                        });
                      },
                      onTapUp: (TapUpDetails details) {
                        setState(() {
                          _pressed = false;
                          print(_pressed);
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          _pressed = false;
                          print(_pressed);
                        });
                      },
                      child: FlatButton(
                        //highlightColor: Colors.black,
                        onPressed: verifyPhone,
                        child: Text(
                          'Verify',
                          style: GoogleFonts.vt323(fontSize: 20),
                        ),
                        textColor: _pressed ? Colors.white : Colors.black,
                        color: _pressed ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
