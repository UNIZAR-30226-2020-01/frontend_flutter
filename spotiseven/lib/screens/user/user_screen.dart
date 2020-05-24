import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotiseven/generic_components/GenericElementList.dart';
import 'package:spotiseven/screens/splashScreen/splash_screen.dart';
import 'package:spotiseven/screens/user/user_edit_screen.dart';
import 'package:spotiseven/user/tokenSingleton.dart';
import 'package:spotiseven/user/user.dart';
import 'package:spotiseven/user/userDAO.dart';

import '../../usefullMethods.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  User _user;

  // Gestión de los seguidores
  List<User> following;
  List<User> followers;
  bool hayFollowers = false;
  bool hayFollowing = false;

  @override
  void initState() {
    _user = null;
    UserDAO.getUserData().then((User user) {
      setState(() {
        _user = user;
      });
      _fetchData();
    });
    super.initState();
  }

  Future _fetchData() async {
    following = await UserDAO.following(_user);
    followers = await UserDAO.followers(_user);
    checkFollowing();
    checkFollowers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_user != null) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildImage(),
                  _buildUserDetails(),
                  _bar("FOLLOWING"),
                  Expanded(
                    flex: 2,
                    child:
                        Container(color: Colors.white, child: getFollowing()),
                  ),
                  _bar("FOLLOWERS"),
                  Expanded(
                    flex: 2,
                    child:
                        Container(color: Colors.white, child: getFollowers()),
                  ),
                  //_buildLogoutButton(context),
//                _imagePicker(),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget getFollowers() {
    String x = 'FOLLOWERS: ';
    if (hayFollowers) {
      return GenericElementList(lista: followers);
    } else
      return Text('no hay followers');
  }

  Widget getFollowing() {
    String x = 'FOLLOWIN: ';
    if (hayFollowing) {
      print('get Following: hay followeers');
      return GenericElementList(lista: following);
    } else
      return Text('no hay following');
  }

  void checkFollowing() {
    if (following.length > 0) {
      print('check: hay following');
      hayFollowing = true;
    }
  }

  void checkFollowers() {
    if (following.length > 0) {
      print('check: hay followers');
      hayFollowers = true;
    }
  }

  Widget _buildImage() {
    String networkImage = _user.imageUrl ??
        'https://pngimage.net/wp-content/uploads/2018/05/default-user-profile-image-png-7.png';
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(networkImage),
          fit: BoxFit.cover,
        )),
        width: double.infinity,
      ),
    );
  }

  Widget _buildUserDetails() {
    if (_user != null) {
      return Expanded(
          flex: 1,
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: _userItem(context, '${_user.username}')));
    } else {
      return SizedBox();
    }
  }

  Widget _buildLogoutButton(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        await TokenSingleton().deleteFromSecure();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashScreen()));
      },
      child: Text('Log out'),
    );
  }

  Widget _bar(String s) {
    return Container(
      color: Colors.black,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UsefulMethods.text(s, 25.0, 2.0, 255, 255, 255, 1.0),
        ],
      ),
    );
  }

  Widget _userItem(context, String s) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: _boxDeco(),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Center(
        child: UsefulMethods.text(s, 25.0, 2.0, 255, 255, 255, 1.0),
      ),
    );
  }

  _boxDeco() {
    return BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(25),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () async {
          print('Editar usuario');
          User us = await Navigator.push(context, MaterialPageRoute(builder: (context) => UserEditScreen(user: _user,)));
          if(us != null){
            print('Ha habido cambios. Recargando');
            setState(() {
              _user = us;
            });
          }
        },
        icon: Icon(Icons.edit),
        color: Colors.white,
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            await TokenSingleton().deleteFromSecure();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SplashScreen()));
          },
          child: Text('LOG OUT', style: TextStyle(color: Colors.red[800]),),
        )
      ],
    );
  }
}
