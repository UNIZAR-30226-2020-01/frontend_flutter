import 'package:flutter/material.dart';
import 'package:spotiseven/user/user.dart';

class UserScreenFounded extends StatefulWidget {
  User user;

  UserScreenFounded({@required this.user});
  @override
  _UserScreenFoundedState createState() => _UserScreenFoundedState();
}

class _UserScreenFoundedState extends State<UserScreenFounded> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.user.url)
                )
              ),
            ),
          ),
          Expanded(
            flex: 3,
          )
        ],
      ),
    );
  }
}
