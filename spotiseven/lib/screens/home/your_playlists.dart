import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/playlistDAO.dart';
import 'dart:convert';
// Clase PlaylistCardWidget
import 'package:spotiseven/screens/home/details/playlist_detail.dart';
// Clase Song
import 'package:spotiseven/audio/utils/song.dart';
// Clase Album
import 'package:spotiseven/audio/utils/album.dart';
// Clase Playlist
import 'package:spotiseven/audio/utils/playlist.dart';

class PlaylistsScreen extends StatefulWidget {
    @override
  _PlaylistsScreenState createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {

  List<Playlist> _listPlaylist;

  ScrollController _scrollController;

  @override
  void initState() {
    _listPlaylist = List();
    _scrollController = ScrollController();
    PlaylistDAO.getAllPlaylists().then((List<Playlist> list) => setState(() {
      _listPlaylist = list;
    }));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_listPlaylist.isNotEmpty){
      return CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverGrid.count(
            crossAxisCount: 2,
            children: _listPlaylist
                .map((el) => PlaylistCardWidget(
              playlist: el,
            ))
                .toList(),
          ),
        ],
      );
    }else{
      return Center(child: CircularProgressIndicator(),);
    }
  }
}
