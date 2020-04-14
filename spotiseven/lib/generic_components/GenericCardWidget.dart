import 'package:flutter/material.dart';
import 'package:spotiseven/usefullMethods.dart';

class GenericCardWidget extends StatelessWidget {
  final String imageUrl;

  final List<Widget> args;

  final Function onPressedFunction;

  GenericCardWidget({this.args, this.imageUrl, this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(left: 35, right: 35, top: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.black,
      child: FlatButton(
        onPressed: onPressedFunction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // TODO: Cambiar estos expanded si la cosa va mal
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
//                    width: MediaQuery.of(context).size.width / 2.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: args,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
