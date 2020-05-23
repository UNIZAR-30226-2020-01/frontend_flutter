import 'package:flutter/material.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/DAO/playlistDAO.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/screens/playlist/create_playlist.dart';

class PopUpSong extends StatelessWidget {
  Song s;

  List<Playlist> playlist;

  PopUpSong({this.s, this.playlist});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      color: Colors.white,
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'add_next',
          child: Text('Play Next'),
        ),
        PopupMenuItem<String>(
          value: 'add_to_playlist',
          child: Text('Add to playlist'),
        ),
      ],
      onSelected: (String value) async {
        switch (value) {
          case 'add_next':
            PlayingSingleton().addSongNext(s);
            break;
          case 'add_to_playlist':
            print('Añadiendo a playlist');
            String opt = await showDialog<String>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select Playlist to add'),
                    elevation: 0,
                    actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context, 'new');
                            },
                            child: Text(
                              'New Playlist',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          )
                        ] +
                        playlist
                            .map((Playlist pl) => _createPlaylistFlatButton(context, pl, s))
                            .toList(),
                  );
                });
            print('$opt');
            if (opt == 'new') {
              Playlist nueva = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CreatePlaylistScreen()));
              if (nueva != null) {
                // TODO: Cambiar esto para que nueva tenga url
                PlaylistDAO.addSongToPlaylist(nueva, s);
              }
            }
            break;
          default:
            print('No action?');
        }
      },
    );
  }

  FlatButton _createPlaylistFlatButton(BuildContext context, Playlist pl, Song s) {
    return FlatButton(
      onPressed: () {
        print('Añadir cancion ${s.title} a playlist ${pl.title}');
        PlaylistDAO.addSongToPlaylist(pl, s);
        Navigator.pop(context, 'not_new');
      },
      child: Text(
        '${pl.title}',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
