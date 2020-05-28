import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/screens/home/details/user_detail.dart';
import 'package:spotiseven/usefullMethods.dart';
import 'package:spotiseven/user/user.dart';
import 'package:spotiseven/user/userDAO.dart';

class UserFound extends StatefulWidget {
  final String word;

   UserFound({this.word});

  @override
  _UserFoundState createState() => _UserFoundState();
}

class _UserFoundState extends State<UserFound> {

  List<User> founduser;

  ScrollController _scrollController;
  bool loading = true;
  bool vacio = true;
  int offset =0;
  @override
  void initState(){
    UserDAO.searchUser(widget.word).then((List<User> list) => setState(() {
      founduser = list;
      loading = false;
      offset= 8;
      vacio = false;
    }));
//    addImage();
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
    if (offset==0){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else if (founduser.isNotEmpty) {
      return Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                founduser
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
    else if (vacio){
      return UsefulMethods.noItems(context);
    }
    else
      return UsefulMethods.noItems(context);
  }
}
