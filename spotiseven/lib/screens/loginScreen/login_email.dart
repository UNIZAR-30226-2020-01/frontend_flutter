import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    labelText: 'Username',
                  ),
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
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      // Es valido -> procedemos al login
                      print('USER: ${_username.trim()}, PASSWORD: $_password');
                      bool auth_ok = await UserDAO.authUserWithPassword(
                          User(username: this._username.trim()), _password);
                      print('AUTH_OK = $auth_ok');
                      if(!auth_ok){
                        // Error en la autentificacion
                        setState(() {
                          _error = true;
                        });
                      }else{
                        // No ha habido error. Entramos
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
    }else{
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/photo1.png'),
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
