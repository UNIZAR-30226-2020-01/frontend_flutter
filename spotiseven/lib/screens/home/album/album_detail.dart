import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        // TODO: Change this color
        border:
            Border.all(width: 1, color: Colors.cyan[100], style: BorderStyle.solid),
        // TODO: Change this color
        color: Colors.cyan[100],
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2.3,
        height: MediaQuery.of(context).size.width / 2.3 + 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                  'https://yt3.ggpht.com/a/AATXAJzgtF2V2m4KsP1ZHU12UcqzoDBEL4GH4e_CmQ=s288-c-k-c0xffffffff-no-rj-mo'),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Motivation'),
                  Text('Haykk'),
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
