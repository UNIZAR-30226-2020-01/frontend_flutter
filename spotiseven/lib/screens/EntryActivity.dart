import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generic_components/GenericLoginButton.dart';

class EntryActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Cambiar color
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Espacio inicial
            SizedBox(
              height: 20,
            ),
            // Imagen de cabecera
            SizedBox(
                height: 200,
                width: 250,
                child: Container(
                  color: Colors.green,
                )),
            // Espacio en blanco entre la imagen y las opciones
            SizedBox(
              height: 50,
            ),
            // Log in with email
            GenericLoginFunction(label: 'LOG IN WITH EMAIL', onPressedFunction: () => print('Login with email'),),
            // Espaciado entre botones
            SizedBox(
              height: 15,
            ),
            // Log in with google
            GenericLoginFunction(label: 'LOG IN WITH GOOGLE', onPressedFunction: () => print('Login with google'),),
            // Sign up
            SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => print('Sign up button pressed'),
      child: Text(
          'No account? Sign up',
        style: TextStyle(
          // TODO: Cambiar el estilo del texto
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
