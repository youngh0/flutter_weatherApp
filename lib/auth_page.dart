import 'package:flutter/material.dart';
import 'package:login_firebase/firebase_provider.dart';
import 'package:login_firebase/screens/loginIn.dart';
import 'package:login_firebase/screens/signUp.dart';
import 'package:provider/provider.dart';

AuthPageState pageState;

class AuthPage extends StatefulWidget {
  @override
  AuthPageState createState() {
    pageState = AuthPageState();
    return pageState;
  }
}

class AuthPageState extends State<AuthPage> {
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    logger.d("user: ${fp.getUser()}");
    if (fp.getUser() != null) {
      return LoginIn();
    } else {
      return SignUp();
    }
  }
}