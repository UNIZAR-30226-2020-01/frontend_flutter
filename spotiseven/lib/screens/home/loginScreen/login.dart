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
      body: Stack(
        children: <Widget>[
          //children: SafeArea(
          Container(
            child: Opacity(
              opacity: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/photo1.png')),
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/welcome.png')),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      //Spacer(),
                      RaisedButton(
                        color: Color.fromRGBO(115, 175, 197, 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        onPressed: () async {
                          // TODO: meter backend
                        },
                        child: Container(
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        color: Color.fromRGBO(115, 175, 197, 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        onPressed: () async {
                          // TODO: meter backedn
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
                          child: Center(
                            child: Text(
                              'LOG IN WITH GOOGLE',
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
