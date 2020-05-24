import 'package:flutter/material.dart';
import 'package:spotiseven/usefullMethods.dart';
import 'package:spotiseven/user/user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:spotiseven/user/userDAO.dart';

class UserEditScreen extends StatefulWidget {
  User user;

  UserEditScreen({this.user});

  @override
  _UserEditScreenState createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  File _image;
  String _name;

  @override
  void initState() {
    _image = null;
    _name = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
      ),
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
                _buildSubmitButton()
                //_buildLogoutButton(context),
//                _imagePicker(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetails() {
    if (widget.user != null) {
      return Expanded(
          flex: 1,
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: TextField(
                onChanged: (value) => _name = value,
                decoration: InputDecoration(
                  labelText: 'USERNAME',
                ),
                cursorColor: Colors.black,

              )));
    } else {
      return SizedBox();
    }
  }

  Widget _buildImage() {
    String networkImage = widget.user.imageUrl ??
        'https://pngimage.net/wp-content/uploads/2018/05/default-user-profile-image-png-7.png';
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: _uploadImage,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(networkImage),
            fit: BoxFit.cover,
          )),
          width: double.infinity,
        ),
      ),
    );
  }

  void _uploadImage() async {
    print('upload image');
    File im = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (im != null) {
      setState(() {
        _image = im;
      });
    }
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      onPressed: () {
        print('Submit');
        if(_image != null){
          // Ha cambiado la imagen
        }
        if(_name.trim() != ""){
          // Ha cambiado el nombre
        }
      },
      child: UsefulMethods.text("save", 20.0, 1.0, 0, 0, 0, 1.0),
    );
  }
}
