import 'package:flutter/material.dart';
import 'package:login_firebase/firebase_provider.dart';
import 'package:login_firebase/screens/signUp.dart';
import 'package:login_firebase/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:login_firebase/weather_main.dart';

class LoginIn extends StatefulWidget {
  @override
  _LoginInState createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

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
                    "Sign in",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildEmailTextField(),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildPWTextField(),
                  buildForgetPW(),
                  buildLoginBtn(),
                  buildTextForm(),
                  SizedBox(height: 20.0),
                  buildSocialBtn(),
                  SizedBox(height: 50.0,),
                  buildSignUpText()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignUpText() {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                  color: Colors.white,

                  fontWeight: FontWeight.w400
              ),
            ),
            TextSpan(
              text: 'sign up',
              style: TextStyle(
                  color: Colors.white,

                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
  Row buildSocialBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  //offset: Offset(0, 2),
                  //blurRadius: 6.0,
                )
              ],
              image: DecorationImage(
                  image: AssetImage('assets/google.png'))),
        ),
        //SizedBox(width: 0.0,),
        Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                )
              ],
              image: DecorationImage(
                  image: AssetImage('assets/facebook.png'))),
        ),
      ],
    );
  }
  Widget buildTextForm() {
    return Column(
      children: <Widget>[
        Text(
          "- OR -",
          style: TextStyle(color: Colors.white, ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'sign in with',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          _logIn();
        },
        padding: EdgeInsets.all((15.0)),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white,
        child: Text(
          "LOGIN",
          style: TextStyle(
              color: btnTextColor,
              //letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
      ),
    );
  }
  Widget buildForgetPW() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          print("click button");
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          "Forgot password?",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  Widget buildPWTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Password",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginBoxDeco,
          height: 50.0,
          child: TextField(
            controller: _pwController,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.vpn_key,
                //color: Colors.white,
              ),
              hintText: 'Enter your password',
              hintStyle: TextStyle(
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Email",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.center,
          decoration: loginBoxDeco,
          height: 50.0,
          child: TextField(
            controller: _idController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                ),
                hintText: "Enter your email here",
                hintStyle: TextStyle(color: Colors.white54)),
          ),
        )
      ],
    );
  }

  void _logIn() async{
    _scaffoldKey.currentState..hideCurrentSnackBar()..showSnackBar(SnackBar(
      duration: Duration(seconds: 10),
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          Text(' 로그 중입니다...'),
        ],
      ),
    ));
    bool result = await fp.signInWithEmail(_idController.text, _pwController.text);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if(result){
      Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherApp()));
      //Navigator.pop(context);
    }else{
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              title: new Text('fail'),
              content: new Text('fail to log-in'),
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
//
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
