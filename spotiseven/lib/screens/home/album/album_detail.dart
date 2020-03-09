import 'package:flutter/material.dart';

class AlbumCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      // TODO: Change this color
      color: Colors.cyan,
      child: SizedBox(
        height: 300,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Image.network(
                  'https://pbs.twimg.com/profile_images/1149261474721931264/sn3du0BK_400x400.jpg'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // TODO: Change style for text
                  Text('PLAYLIST'),
                  Text('Hayk'),
                  Text('25 songs'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
