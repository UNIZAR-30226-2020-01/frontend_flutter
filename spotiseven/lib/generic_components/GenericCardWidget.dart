import 'package:flutter/material.dart';
import 'package:spotiseven/usefullMethods.dart';

class GenericCardWidget extends StatelessWidget {
   String imageUrl;

  final List<Widget> args;

  final Function onPressedFunction;

  GenericCardWidget({this.args, this.imageUrl, this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null){
      imageUrl = "https://imgur.com/a/7c3Y8pR";
    }
    return Card(
      elevation: 3,
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
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
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
