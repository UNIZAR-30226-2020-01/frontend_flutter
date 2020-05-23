import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotiseven/screens/splashScreen/splash_screen.dart';
import 'package:spotiseven/user/tokenSingleton.dart';
import 'package:spotiseven/user/user.dart';
import 'package:spotiseven/user/userDAO.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // Campos de la playlist
  String _title;
  // Imagen de la playlist
  File _image;

  @override
  void initState() {
    _title = '';
    _image = null;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildUserDetails(),
              _buildLogoutButton(context),
              _imagePicker(),
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

  Widget _imagePicker() {
    if (_image != null) {
      // La imagen tiene valor.
      return GestureDetector(
        onTap: _uploadImage,
        child: Container(
            width: MediaQuery.of(context).size.width*0.7,
            height: MediaQuery.of(context).size.height*0.5,
            child: AspectRatio(
                aspectRatio: 1,
                child: Image.file(_image))
        ),
      );
    }else{
      // Boton de seleccionar una imagen
      return FlatButton(
        onPressed: _uploadImage,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Icon(Icons.image),
            ),
            Expanded(
              flex: 10,
              child: Text('Select image to upload'),
            )
          ],
        ),
      );
    }
  }

  void _uploadImage() async {
    print('upload image');
    File im = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(im != null){
      setState(() {
        _image = im;
      });
    }
  }
}


