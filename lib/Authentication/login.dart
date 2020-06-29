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
              style: GoogleFonts.vt323(fontSize: 20),
            ),
            content: TextField(
              decoration: InputDecoration(
                hintText: 'OTP',
                hintStyle: GoogleFonts.vt323(fontSize: 20),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              cursorColor: Colors.black,
              textAlign: TextAlign.center,
              style: GoogleFonts.vt323(fontSize: 20),
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
                  style: GoogleFonts.vt323(fontSize: 20),
                ),
                textColor: Colors.black,
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
                  height: 50,
                  child: Text(
                    'Login',
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
              child: Container(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/login.png'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Unique ID',
                        hintStyle: GoogleFonts.vt323(fontSize: 20),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      cursorColor: Colors.black,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vt323(fontSize: 20),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter phone number with country code',
                        hintStyle: GoogleFonts.vt323(fontSize: 20),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      cursorColor: Colors.black,
                      //keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vt323(fontSize: 20),
                      onChanged: (value) {
                        this.phoneNo = value;
                      },
                    ),
                    SizedBox(height: 10.0),
                    FlatButton(
                      onPressed: verifyPhone,
                      child: Text(
                        'Verify',
                        style: GoogleFonts.vt323(fontSize: 22),
                      ),
                      textColor: Colors.white,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white),
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
