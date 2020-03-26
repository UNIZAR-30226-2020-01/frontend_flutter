import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginEmail2 extends StatefulWidget {
  @override
  _LoginMailState createState() => _LoginMailState();
}

class _LoginMailState extends State<LoginEmail2> {
  // Se iniciara la autovalidacion tras el primer intento de submit
  bool _autovalid = false;

  // Para mostrar errores
  String _error;

  final _formKey = GlobalKey<FormState>();

  String email;
  String password;

  _header() {
    return Container(
      height: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/spotiseven.png')),
        ),
      ),
    );
  }

  _form() {
    return Container(
      height: MediaQuery.of(context).size.width * 0.9,
      child: Form(
        autovalidate: _autovalid,
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
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
                  height: 10,
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
                  height: 10,
                ),
              ]),
        ),
      ),
    );
  }

  _submit() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.115,
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
    );
  }

  _background() {
    return Container(
      child: Opacity(
        opacity: 0.4,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/photo1.png')),
          ),
        ),
      ),
    );
  }

  _elements() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _header(),
        _form(),
        _submit(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover),
        ),
        child: ListView(
          children: <Widget>[
            //_background(),
            _elements(),
          ],
        ),
      ),
    );
  }
}
