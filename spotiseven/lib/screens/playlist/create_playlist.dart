import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:spotiseven/audio/utils/DAO/playlistDAO.dart';
import 'package:spotiseven/audio/utils/playlist.dart';

class CreatePlaylistScreen extends StatefulWidget {
  @override
  _CreatePlaylistScreenState createState() => _CreatePlaylistScreenState();
}

class _CreatePlaylistScreenState extends State<CreatePlaylistScreen> {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('New Playlist'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context, null),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: ListView(
          children: <Widget>[
            _imagePicker(),
            TextField(
              onChanged: (value) => _title = value,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                Playlist pl = Playlist(
                  title: _title,
                )..playlist = List();
                pl = await PlaylistDAO.createPlaylist(pl, _image);
                // Devolvemos la playlist creada a la pila
                Navigator.pop(context, pl);
              },
              child: Text('ADD PLAYLIST'),
            ),
          ],
        ),
      ),
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
