import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/user/tokenSingleton.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  _noAccount(){
    return FlatButton(
      onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
      child: Text(
        'NO ACCOUNT? SIGN IN NOW!',
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }

  _googleButton(){
    return RaisedButton(
      color: Color.fromRGBO(255, 255, 255, 0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
      onPressed: () async {
        print('Login con google');
        if(await TokenSingleton().getTokenFromGoogle()){
          // Se ha logueado bien
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
        child: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                    height: 20,
                    child: Image.asset(
                        'assets/images/google.png'
                    )
                ),
              ),
              Expanded(
                flex: 12,
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Center(
                    child: Text(
                      'LOG IN WITH GOOGLE',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 18,
                        letterSpacing: 3,
                        wordSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _logginButton(){
    return RaisedButton(
      color: Color.fromRGBO(255, 255, 255, 0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
      onPressed: () async {
        Navigator.pushNamed(context, '/loginMail');
      },
      child: Row(
        children: <Widget>[
          Expanded(flex:1, child: Icon(Icons.email)),
          Expanded(
            flex: 12,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
              child: Center(
                child: Text(
                  'LOG IN WITH USERNAME',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 18,
                    letterSpacing: 3,
                    wordSpacing: 3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.03 ,),
            Container(
              height: MediaQuery.of(context).size.height*0.3 ,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/all_logo.png')),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.2 ,),
            Padding(
              padding:const EdgeInsets.fromLTRB(45, 0, 45, 20),
              child: _logginButton(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
              child: _googleButton(),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: _noAccount(),
            ),
          ],
        ),


      ),
    );
  }
}
