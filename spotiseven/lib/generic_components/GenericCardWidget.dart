import 'package:flutter/material.dart';

class GenericCardWidget extends StatelessWidget {
  final String imageUrl;

  final List<Widget> args;

  final Function onPressedFunction;

  GenericCardWidget({this.args, this.imageUrl, this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(left: 15, right: 10, top: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      color: Colors.grey,
      child: FlatButton(
        onPressed: onPressedFunction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                imageUrl,
                width: MediaQuery.of(context).size.width / 2.5,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: args,
              ),
            ),
          ],
        ),
      ),
    );
// Diseño viejo
//    return Container(
//      margin: EdgeInsets.only(left: 15, right: 10),
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.all(Radius.circular(40)),
//        // TODO: Change this color
//        border: Border.all(
//            width: 1, color: Colors.cyan[100], style: BorderStyle.solid),
//        // TODO: Change this color
//        color: Colors.cyan[100],
//      ),
//      width: MediaQuery.of(context).size.width / 2.3,
//      height: MediaQuery.of(context).size.width / 2.3 + 100,
//      child: FlatButton(
//        onPressed: onPressedFunction,
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            ClipRRect(
//              borderRadius: BorderRadius.circular(40),
//              child: Image.network(imageUrl),
//            ),
//            Container(
//              padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: args,
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
  }
}
