import 'package:flutter/material.dart';
import 'package:login_firebase/auth_page.dart';

import 'package:provider/provider.dart';
import 'firebase_provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseProvider>(
            create: (_) => FirebaseProvider(),)
      ],
      child: MaterialApp(
        title: "Flutter Firebase",
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Flutter Firebase")),
      body: AuthPage(),
    );
  }
}

