import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login_firebase/firebase_provider.dart';
import 'package:login_firebase/screens/loginIn.dart';
import 'package:login_firebase/shared/constants.dart';
import 'package:provider/provider.dart';
import 'loginIn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _confirmPwController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;


  @override
  void dispose(){
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    login_Gradient1,
                    login_Gradient2,
                    login_Gradient3,
                    login_Gradient4,
                  ],
                )),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 100.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildNameTextFiled(),
                  SizedBox(height: 20.0,),
                  buildPhoneTextField(),
                  SizedBox(height: 20.0,),
                  buildEmailTextFiled(),
                  SizedBox(height: 20.0,),
                  buildPWTextField(),
                  SizedBox(height: 20.0,),
                  buildConfirmPW(),
                  buildRegisterBtn(),
                  buildSignInText()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignInText() {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginIn()));
      },
      child: RichText(
        text: TextSpan(
            children: [
              TextSpan(
                text: 'Have an Account? ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                ),
              ),
              TextSpan(
                text: 'Sign in',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              )
            ]
        ),
      ),
    );
  }
  Widget buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 10.0,
        onPressed: () {
          if(_pwController.text != _confirmPwController.text){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),

                    title: new Text('check your password'),
                    content: new Text('different'),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('close'),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                });
          }
          else{
            _signUp();
          }
        },
        padding: EdgeInsets.all((15.0)),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white,
        child: Text(
          "REGISTER",
          style: TextStyle(
              color: btnTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        ),
      ),
    );
  }
  Widget buildConfirmPW() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'confirm password',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginBoxDeco,
          height: 40.0,
          child: TextField(
            controller: _confirmPwController,
            obscureText: true,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key),
                hintText: 'Confirm password',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none
            ),
          ),
        )
      ],
    );
  }
  Widget buildPWTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0,),
        Container(
          decoration: loginBoxDeco,
          height: 40.0,
          child: TextField(
            controller: _pwController,
            style: TextStyle(color: Colors.white),
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.vpn_key),
                hintText: 'Enter your Password',
                hintStyle: TextStyle(color: Colors.white54)
            ),
          ),
        )
      ],
    );
  }
  Widget buildEmailTextFiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10.0,),
        Container(
          decoration: loginBoxDeco,
          height: 40.0,
          child: TextField(
            controller: _idController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.email,),
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.white54,fontSize: 15.0)

            ),
          ),
        )
      ],
    );
  }
  Widget buildPhoneTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'phone No',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10.0,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginBoxDeco,
          height: 40.0,
          child: TextField(
            keyboardType: TextInputType.phone,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                //contentPadding: EdgeInsets.only(top: 10.0),
                prefixIcon: Icon(Icons.phone,),
                hintText: 'Enter your Phone Number',
                hintStyle: TextStyle(
                    color: Colors.white54,
                    fontSize: 15.0
                )
            ),
          ),
        )
      ],
    );
  }
  Widget buildNameTextFiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Full Name',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginBoxDeco,
          height: 40.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                //contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.person,
                ),
                hintText: 'Enter your Name',
                hintStyle: TextStyle(
                    color: Colors.white54, fontSize: 15.0)),
          ),
        )
      ],
    );
  }
  void _signUp() async{
    _scaffoldKey.currentState..hideCurrentSnackBar()..showSnackBar(SnackBar(
      duration: Duration(seconds: 10),
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          Text(' 가입 중입니다...'),
        ],
      ),
    ));
    bool result = await fp.signUpWithEmail(_idController.text, _pwController.text);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if(result){
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginIn()));
      //Navigator.pop(context) 이걸하면 화면이 이상해짐
    }else{
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),

              title: new Text('fail'),
              content: new Text('fail to sign up'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('close'),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

//  void _confirmPw() {
//    showDialog(
//        context: context,
//    builder: (BuildContext context){
//          return AlertDialog(
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(10.0)
//            ),
//
//            title: new Text('fail'),
//            content: new Text('fail to sign up'),
//            actions: <Widget>[
//              new FlatButton(
//                child: new Text('close'),
//                onPressed: (){
//                  Navigator.pop(context);
//                },
//              )
//            ],
//          );
//    });
//  }

//  showLastFBMessage() {
//    _scaffoldKey.currentState
//      ..hideCurrentSnackBar()
//      ..showSnackBar(SnackBar(
//        backgroundColor: Colors.red[400],
//        duration: Duration(seconds: 10),
//        content: Text(fp.getLastFBMessage()),
//        action: SnackBarAction(
//          label: "Done",
//          textColor: Colors.white,
//          onPressed: () {},
//        ),
//      ));
//  }


}
