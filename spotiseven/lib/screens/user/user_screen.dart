import 'package:flutter/material.dart';
import 'package:spotiseven/screens/splashScreen/splash_screen.dart';
import 'package:spotiseven/user/tokenSingleton.dart';
import 'package:spotiseven/user/user.dart';
import 'package:spotiseven/user/userDAO.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildUserDetails(),
              _buildLogoutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetails() {
    return FutureBuilder(
      future: UserDAO.getUserData(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('${(snapshot.data as User).username}'),
              Text('More user stuff here'),
            ],
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        await TokenSingleton().deleteFromSecure();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));
      },
      child: Text('Log out'),
    );
  }
}
