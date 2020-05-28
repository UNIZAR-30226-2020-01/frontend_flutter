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
  @override
  void initState(){
    UserDAO.searchUser(widget.word).then((List<User> list) => setState(() {
      founduser = list;
      loading = false;
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
    if (loading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else if(!loading && founduser != null){
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
    else if(founduser.isEmpty){
      return UsefulMethods.noItems(context);
    }
    else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
