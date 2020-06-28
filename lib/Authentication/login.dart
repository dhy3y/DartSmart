import 'package:DartSmart/article.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
            title: Text('Enter OTP'),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done!'),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new Article()),
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
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Authentication'),
      ),
      
      body: new Center(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(Icons.phone_android, size: 150.0, color: Colors.black),
              TextField(
                decoration: InputDecoration(hintText: 'Enter Unique ID'),
                textAlign: TextAlign.center,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Enter phone number with country code'),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  this.phoneNo = value;
                },
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                  onPressed: verifyPhone,
                  child: Text('Verify'),
                  textColor: Colors.white,
                  elevation: 7.0,
                  color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
