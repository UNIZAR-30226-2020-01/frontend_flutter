import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/song.dart';

class ActualPlaylistScreen extends StatefulWidget {
  final Playlist playlist;

  ActualPlaylistScreen({this.playlist});

  @override
  _ActualPlaylistScreenState createState() => _ActualPlaylistScreenState();
}

class _ActualPlaylistScreenState extends State<ActualPlaylistScreen> {
  PlayingSingleton _playingSingleton = PlayingSingleton();
  StreamSubscription _subscription;

  @override
  void initState() {
    print('${_remainingSongs().map((Song s) => s.title).toString()}');
    _subscription =
        _playingSingleton.getStreamedSong().listen((Song s) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var remaining_list = _remainingSongs();
    return Scaffold(
      body: SafeArea(
        child: ReorderableListView(
          header: ListTile(
            leading: Image.network('${_playingSingleton.song.photoUrl}'),
            title: Text(
              '${_playingSingleton.song.title}',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${_playingSingleton.song.album.artista}'),
            trailing: Icon(Icons.play_arrow),
            isThreeLine: false,
          ),
          onReorder: (int oldIndex, int newIndex) {
            print('OLD: $oldIndex --- NEW: $newIndex');
            // newIndex siempre sera +1 (no puede ser nunca 0)
            _playingSingleton.reorderPlaylist(
                remaining_list[oldIndex],
                newIndex == remaining_list.length - 1
                    ? newIndex
                    : newIndex);
            setState(() {});
          },
          children: List.generate(remaining_list.length, (int index) {
            Song s = remaining_list[index];
            return ListTile(
              key: Key('$index'),
              leading: AspectRatio(
                  aspectRatio: 1, child: Image.network('${s.photoUrl}')),
              title: Text('${s.title}'),
              subtitle: Text('${s.album.artista}'),
              isThreeLine: false,
              trailing: Icon(Icons.drag_handle),
              onTap: () => _playingSingleton.play(s),
            );
          }),
        ),
//        child: Column(
//          children: <Widget>[

//            ReorderableListView(
//              onReorder: (int oldIndex, int newIndex) {
//                print('OLD: $oldIndex --- NEW: $newIndex');
//              },
//              children: List.generate(remaining_list.length, (int index){
//                Song s = remaining_list[index];
//                return ListTile(
//                  key: Key('$index'),
//                  leading: Image.network('${s.photoUrl}'),
//                  title: Text('${s.title}'),
//                  subtitle: Text(''),
//                  isThreeLine: true,
//                );
//              }),
//            ),
//          ],
//        ),
      ),
    );
  }

  List<Song> _remainingSongs() {
    List<Song> list = [];
    for (Song s in _playingSingleton.playlist.playlist) {
      if (s != _playingSingleton.song) {
        list += [s];
      }
    }
    return list;
  }
}
