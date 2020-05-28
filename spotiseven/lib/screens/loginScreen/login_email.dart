import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/usefullMethods.dart';
import 'package:spotiseven/user/user.dart';
import 'package:spotiseven/user/userDAO.dart';

class LoginEmail extends StatefulWidget {
  @override
  _LoginMailState createState() => _LoginMailState();
}

class _LoginMailState extends State<LoginEmail> {
  // Se iniciara la autovalidacion tras el primer intento de submit
  bool _autovalid = false;

  // Para mostrar errores
  bool _error = false;

  final _formKey = GlobalKey<FormState>();

  String _username;
  String _password;

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
                    labelText: 'USERNAME',
                  ),
                  cursorColor: Colors.black,
                  validator: (value) {
                    Pattern pattern = r'^[^0-9].*$';
                    RegExp regex = new RegExp(pattern);
                    if (value.isEmpty || !regex.hasMatch(value)) {
                      return 'Introduce una dirección de correo valida';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => this._username = value,
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
                  cursorColor: Colors.black,
                  validator: (String value) {
                    if (value.isEmpty && value.length < 8) {
                      return 'Debes introducir una contraseña';
                    } else if (value.length < 8) {
                      return 'La contraseña introducida es muy corta';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => this._password = value,
                ),
                SizedBox(
                  height: 10,
                ),
                _showError(),
                RaisedButton(
                  color: Color.fromRGBO(0, 0, 0, 0.8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
                  child: Container(
                    height: 40,
                    child: Center(
                      child: UsefulMethods.text('log in', 23.0, 3.0, 255, 255, 255, 1.0),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      // Es valido -> procedemos al login
                      print('USER: ${_username.trim()}, PASSWORD: $_password');
                      bool auth_ok = await UserDAO.authUserWithPassword(
                          User(username: this._username.trim()), _password);
                      print('AUTH_OK = $auth_ok');
                      if (!auth_ok) {
                        // Error en la autentificacion
                        setState(() {
                          _error = true;
                        });
                      } else {
                        CircularProgressIndicator();
//                        Navigator.popAndPushNamed(context, '/home');
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    } else {
                      // Error -> activamos la autovalidacion
                      setState(() {
                        _autovalid = true;
                      });
                    }
                  },
                ),
              ]),
        ),
      ),
    );
  }

  Widget _showError() {
    if (_error) {
      return Text(
        'Usuario o contraseña incorrectos',
        style: TextStyle(
          fontSize: 18,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
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
                itemExtent: 400.00,
                delegate: SliverChildListDelegate([
                  _form(),
                ]),
              )
            ],
          ),
        ),
        ),
//      ),
    );
  }
}
/*child: CustomScrollView(
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
        ),*/
