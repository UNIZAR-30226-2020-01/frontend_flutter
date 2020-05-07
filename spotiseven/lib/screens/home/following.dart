import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/screens/home/details/playlist_detail.dart';
import 'package:spotiseven/user/userDAO.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {

  List<Playlist> _followingUserPlaylist;

  ScrollController _scrollController;


  @override
  void initState() {
    _followingUserPlaylist = List();
    _scrollController = ScrollController();
    UserDAO.followingPlaylists().then((List<Playlist> lp) => setState(() {
      _followingUserPlaylist = lp;
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
    if(_followingUserPlaylist.isNotEmpty){
      return CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverGrid.count(
            crossAxisCount: 2,
            children: _followingUserPlaylist
                .map((el) => PlaylistCardWidget(
              playlist: el,
            ))
                .toList(),
          ),
        ],
      );
    }else{
      return Center(child: CircularProgressIndicator(),);
    }  }
}