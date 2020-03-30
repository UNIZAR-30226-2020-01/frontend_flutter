import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Se iniciara la autovalidacion tras el primer intento de submit
  bool _autovalid = false;
  // Para mostrar errores
  String _error;

  final _formKey = GlobalKey<FormState>();

  String email;
  String password;

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
              child: RaisedButton(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
                onPressed: () async {
                  Navigator.popAndPushNamed(context, '/loginMail');
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.email),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
                      child: Center(
                        child: Text(
                          'LOG IN WITH EMAIL',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 20,
                            letterSpacing: 3,
                            wordSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
              child: RaisedButton(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
                onPressed: () async {
                  // TODO: meter backend
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 20,
                            child: Image.asset(
                                'assets/images/google.png'
                            )
                        ),
                        SizedBox(width: 10,),
                        /*Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/google.png'),
                            ),
                          ),
                        ),*/
                        Text(
                          'LOG IN WITH GOOGLE',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 18,
                            letterSpacing: 3,
                            wordSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'NO ACCOUNT? SIGN IN NOW!',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            // TODO: Quitar, es para pruebas
            RaisedButton(
                          onPressed: () => Navigator.popAndPushNamed(context, '/home'),
                          child: Text('ENTRAR A LA PANTALLA PRINCIPAL'),
                        ),
          ],
        ),


      ),
    );
  }
}
