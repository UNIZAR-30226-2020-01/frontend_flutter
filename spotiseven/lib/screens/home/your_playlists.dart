import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/DAO/playlistDAO.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/screens/home/details/playlist_detail.dart';

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
