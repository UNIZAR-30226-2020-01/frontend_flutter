import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotiseven/screens/main_screen.dart';
import 'package:spotiseven/screens/loginScreen/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    _mockCheckForSession().then(
            (status) {
          if (status) {
            _navigateToHome();
          } else {
            _navigateToLogin();
          }
        }
    );
  }

  Future<bool> _mockCheckForSession() async{
    //TODO: check de si el usuario está logeado
    await Future.delayed(Duration(milliseconds: 1800), () {});
    /*if(FirebaseAuth.instance.currentUser() != null) return true;
    else return false;*/
    return false;
  }

  void _navigateToHome(){
     /* Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainScreenWrapper()
        ));*/
    Navigator.pushNamed(context, '/home');
  }

  void _navigateToLogin(){
    /*Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Login()
    ));*/
    Navigator.pushNamed(context, '/login');
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/gif.gif'),
                )
              ),
            )
          ],
        ),
      ),
    );
  }




}