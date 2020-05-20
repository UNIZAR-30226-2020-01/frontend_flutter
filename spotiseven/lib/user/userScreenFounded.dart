import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/user/user.dart';
import 'package:spotiseven/user/userDAO.dart';

class UserScreenFound extends StatefulWidget {
  User user;


  UserScreenFound({@required this.user});

  @override
  _UserScreenFoundState createState() => _UserScreenFoundState();
}

class _UserScreenFoundState extends State<UserScreenFound> {
  User get user => widget.user;
  List<User> following;
  List<User> followers;
  Text followersAsText = new Text('');
  Text followingAsText = new Text('');

  getFollowers()
  {
    String x = 'FOLLOWERS: ';
    if (followers.length > 0){
      for(var i = 0; i < followers.length; i++){
        x = x+(followers[i].username);
        x = x+ ' - ';
      }
    }
    else x = 'User has no followers';
    setState(() {
      followersAsText = Text(x);
    });
//    followersAsText = Text(x);
  }

  getFollowing()
  {
    String x = 'FOLLOWIN: ';
    if (following.length > 0){
      for(var i = 0; i < following.length; i++){
        x = x+(following[i].username);
        x = x+ ' - ';
      }
    }
    else x = 'User doesnt follow other users';
    setState(() {
      followingAsText = Text(x);
    });
//    followingAsText = Text(x);
  }

  @override
  void initState(){
    super.initState();
    _fetchData();
  }

  Future _fetchData() async{
    following = await UserDAO.following(user);
    followers = await UserDAO.followers(user);
    getFollowing();
    getFollowers();
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
              flex: 2,
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
              flex: 1,
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
                      child: Text(
                        'Username: '+ user.username,
                        style: GoogleFonts.roboto(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    color: Colors.pink,
                    child: followingAsText,
                  ),
                  Container(
                    height: 30,
                    color: Colors.blue,
                    child: followersAsText,
                  ),
                ],
                )
              ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      UserDAO.followUser(user);
                      print('User has been followed');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      height: MediaQuery.of(context).size.height*0.05,
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
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      UserDAO.unfollowUser(user);
                      print('User has been unfollowed');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      height: MediaQuery.of(context).size.height*0.05,
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
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
