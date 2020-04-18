import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/DAO/playlistDAO.dart';
import 'package:spotiseven/audio/utils/playlist.dart';

class CreatePlaylistScreen extends StatefulWidget {
  @override
  _CreatePlaylistScreenState createState() => _CreatePlaylistScreenState();
}

class _CreatePlaylistScreenState extends State<CreatePlaylistScreen> {
  // Campos de la playlist
  String _title;

  @override
  void initState() {
    _title = '';
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) => _title = value,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () => PlaylistDAO.createPlaylist(Playlist(
                title: _title,
              )..playlist = List()),
              child: Text('ADD PLAYLIST'),
            ),
          ],
        ),
      ),
    );
  }
}
