import 'package:flutter/material.dart';

class GenericLoginFunction extends StatelessWidget {

  String label;
  Function onPressedFunction;

  GenericLoginFunction({this.label, this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: RaisedButton(
        // TODO: Cambiar color
        color: Colors.grey[600],
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        onPressed: this.onPressedFunction,
        child: Center(
          child: Text(
            this.label,
            style: TextStyle(
              // TODO: Cambiar el estilo del texto
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}