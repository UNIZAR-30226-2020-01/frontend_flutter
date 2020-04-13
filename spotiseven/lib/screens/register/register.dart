import 'package:flutter/material.dart';
import 'package:spotiseven/user/user.dart';
import 'package:spotiseven/user/userDAO.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Para la validacion del formulario
  final _formKey = GlobalKey<FormState>();
  // Valores a registrar en el formulario
  String _username;
  String _email;
  String _password;

  // Control de errores
  bool _error = false;
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          autovalidate: _autovalidate,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: SizedBox(height: 1,),
              ),
              // Nombre de usuario
              Expanded(
                flex: 6,
                child: Container(
                  decoration: _border(),
                  child: TextFormField(
                    validator: _validateUsername,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      labelText: 'USERNAME',
                      labelStyle: TextStyle(
                        letterSpacing: 2,
                      ),
                    ),
                    onChanged: (value) => _username = value,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(height: 1,),
              ),
              // Email
              Expanded(
                flex: 6,
                child: Container(
                  decoration: _border(),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      labelText: 'EMAIL ADDRESS',
                      labelStyle: TextStyle(
                        letterSpacing: 2,
                      ),
                    ),
                    onChanged: (value) => _email = value,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(height: 1,),
              ),
              // Contraseña
              Expanded(
                flex: 6,
                child: Container(
                  decoration: _border(),
                  child: TextFormField(
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                        letterSpacing: 2,
                      ),
                    ),
                    obscureText: true,
                    onChanged: (value) => _password = value,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: SizedBox(height: 1,),
              ),
              _buildErrors(),
              // Botón de submit
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3),
                  child: RaisedButton(
                    onPressed: () => _submitForm(context),
                    child: Text('REGISTER NOW'),
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: SizedBox(height: 1,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _border() {
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      border: Border(
        top: BorderSide(width: 1.0, color: Colors.black),
        left: BorderSide(width: 1.0, color: Colors.black),
        right: BorderSide(width: 1.0, color: Colors.black),
        bottom: BorderSide(width: 1.0, color: Colors.black),
      ),
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    print('Registrando al usuario');
    if(_formKey.currentState.validate()){
      // Los campos han ido bien
      bool ok = await UserDAO.registerUserWithPassword(User(username: _username.trim()), _password);
      if(ok){
        // TODO: Si no tengo el token -> Peticion para obtenerlo
        // Ha ido bien -> Iniciamos
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        // Algo ha fallado
        setState(() {
          _error = true;
          _autovalidate = true;
        });
      }
    }else{
      // Error en los campos
      setState(() {
        _autovalidate = true;
      });
    }
  }

  Widget _buildErrors(){
    // TODO: Implementar con los
    if(_error){
      return Text('Error. El nombre de usuario no está disponible');
    }else{
      return SizedBox();
    }
  }

  String _validateUsername(String value) {
    if(value != null && value.isNotEmpty && value.trim().isNotEmpty && value.length > 2){
      return null;
    }else{
      return "El nombre de usuario $value no es valido.";
    }
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value)) {
      return 'Introduce una dirección de correo valida';
    } else {
      return null;
    }
  }

  String _validatePassword(String value){
    if(value != null && value.isNotEmpty && !value.contains(r' ') && value.length > 8){
      return null;
    }else{
      return "La contraseña no es válida.";
    }
  }
}
