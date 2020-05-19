import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/screens/home/details/playlist_detail.dart';

class PlaylistFound extends StatefulWidget {
  final List<Playlist> foundpl;

  PlaylistFound({@required this.foundpl});

  @override
  _PlaylistFoundState createState() => _PlaylistFoundState();
}

class _PlaylistFoundState extends State<PlaylistFound> {
  ScrollController _scrollController;
  @override
  void initState(){
//    _listPlaylist = List();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if(widget.foundpl.isNotEmpty){
      return CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverGrid.count(
            crossAxisCount: 2,
            children: widget.foundpl
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

