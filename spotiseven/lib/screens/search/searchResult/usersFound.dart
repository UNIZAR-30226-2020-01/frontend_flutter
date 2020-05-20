import 'package:flutter/material.dart';
import 'package:spotiseven/screens/home/details/user_detail.dart';
import 'package:spotiseven/user/user.dart';

class UserFound extends StatefulWidget {
  final List<User> founduser;

   UserFound({this.founduser});

  @override
  _UserFoundState createState() => _UserFoundState();
}

class _UserFoundState extends State<UserFound> {
  ScrollController _scrollController;
  @override
  void initState(){
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.founduser.isNotEmpty){
      return Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                widget.founduser
                    .map((el) => UserCardWidget(
                  user: el,
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    }
    else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
