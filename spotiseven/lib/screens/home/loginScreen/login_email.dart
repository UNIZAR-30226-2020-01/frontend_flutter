import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginEmail extends StatefulWidget {
  @override
  _LoginMailState createState() => _LoginMailState();
}

class _LoginMailState extends State<LoginEmail> {
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
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          //children: SafeArea(
          Container(
            child: Opacity(
              opacity: 0.4,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/photo1.png')),
                ),
              ),
            ),
          ),
          Column(children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/spotiseven.png')),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Form(
                autovalidate: _autovalid,
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: ListView(
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'EMAIL ADDRESS',
                            ),
                            validator: (value) {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              if (value.isEmpty || !regex.hasMatch(value)) {
                                return 'Introduce una dirección de correo valida';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => this.email = value,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              labelText: 'PASSWORD',
                            ),
                            validator: (String value) {
                              if (value.isEmpty && value.length < 8) {
                                return 'Debes introducir una contraseña';
                              } else if (value.length < 8) {
                                return 'La contraseña introducida es muy corta';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => this.password = value,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              labelText: 'PASSWORD',
                            ),
                            validator: (String value) {
                              if (value.isEmpty && value.length < 8) {
                                return 'Debes introducir una contraseña';
                              } else if (value.length < 8) {
                                return 'La contraseña introducida es muy corta';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => this.password = value,
                          ),

                        ]),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  //height: 1000,
                  width: 250,
                  child: RaisedButton(
                    color: Color.fromRGBO(115, 175, 197, 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print('OK');
                        try {
                          //
                        } on PlatformException catch (e) {
                          print('ERROR ---> $e');
                          setState(() {
                            _error = 'El usuario o la contraseña no son validos';
                          });
                        }
                      }
                    },
                    child: Text(
                      'LOG IN',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20,
                        letterSpacing: 10,
                        wordSpacing: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: 50,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
