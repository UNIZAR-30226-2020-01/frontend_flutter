import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginEmail3 extends StatefulWidget {
  @override
  _LoginMailState createState() => _LoginMailState();
}

class _LoginMailState extends State<LoginEmail3> {
  // Se iniciara la autovalidacion tras el primer intento de submit
  bool _autovalid = false;

  // Para mostrar errores
  String _error;

  final _formKey = GlobalKey<FormState>();

  String email;
  String password;

  _form() {
    return Container(
      //height: MediaQuery.of(context).size.width * 0.9,
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/photo1.png'),
          fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: MediaQuery.of(context).size.height * 0.2,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset('assets/images/spotiseven.png'),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 500.00,
                delegate: SliverChildListDelegate([
                  _form(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}