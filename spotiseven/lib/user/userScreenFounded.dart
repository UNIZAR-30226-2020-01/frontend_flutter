import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/generic_components/GenericElementList.dart';
import 'package:spotiseven/usefullMethods.dart';
import 'package:spotiseven/user/user.dart';
import 'package:spotiseven/user/userDAO.dart';

class UserScreenFound extends StatefulWidget {
  User user;
  List<User> following;
  List<User> followers;

  UserScreenFound({@required this.user});

  @override
  _UserScreenFoundState createState() => _UserScreenFoundState();
}

class _UserScreenFoundState extends State<UserScreenFound> {
  User get user => widget.user;
  List<User> following;
  List<User> followers;
  Widget followersWid ;
  Widget followingWid;
  bool hayFollowers = false;
  bool hayFollowing = false;



  void checkFollowing(){
    if (following.length > 0){
      print('check: hay following');
      hayFollowing = true;
    }
  }
  void checkFollowers(){
    if (following.length > 0){
      print('check: hay followers');
      hayFollowers = true;
    }
  }


  Widget getFollowers()
  {
    String x = 'FOLLOWERS: ';
    if (hayFollowers){
        return GenericElementList(lista: followers);
    }
    else return Text('no hay followers');

  }


  Widget getFollowing()
  {
    String x = 'FOLLOWIN: ';
    if (hayFollowing){
        print('get Following: hay followeers');
        return GenericElementList(lista: following);
    }
    else return Text('no hay following');
  }

  @override
  void initState(){
    super.initState();
    _fetchData();
  }

  Future _fetchData() async{
    following = await UserDAO.following(user);
    followers = await UserDAO.followers(user);
    checkFollowing();
    checkFollowers();
    setState(() {

    });
  }

  _bar(String s) {

    return Container(
      color: Colors.black,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UsefulMethods.text(s, 25.0, 2.0, 255,255,255,1.0),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(user.imageUrl)
                  )
                ),
              ),
            ),
            Divider(color: Colors.black,thickness: 5,),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.7,
                    height: MediaQuery.of(context).size.height*0.07,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                            'Username: '+ user.username,
                            style: GoogleFonts.roboto(
                              fontSize: 35,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          UserDAO.followUser(user);
                          print('User has been followed');
                          setState(() {

                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          height: MediaQuery.of(context).size.height*0.04,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'FOLLOW',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: (){
                          UserDAO.unfollowUser(user);
                          print('User has been unfollowed');
                          setState(() {
                            
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          height: MediaQuery.of(context).size.height*0.04,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'UNFOLLOW',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
                )
              ),
            Expanded(
              flex: 1,
              child: _bar('FOLLOWING'),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: getFollowing()
              ),
            ),
            Expanded(
              flex: 1,
              child: _bar('FOLLOWERS'),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: getFollowers()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
