import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/screens/home/details/playlist_detail.dart';
import 'package:spotiseven/user/userDAO.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {

  bool _initialized;

  List<Playlist> _followingUserPlaylist;

  ScrollController _scrollController;


  @override
  void initState() {
    _initialized = false;
    _followingUserPlaylist = List();
    _scrollController = ScrollController();
    UserDAO.followingPlaylists().then((List<Playlist> lp) => setState(() {
      setState(() {
        _initialized = true;
        _followingUserPlaylist = lp;
      });
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
    }else if(_initialized) {
      // La lista esta inicializada pero está vacía
      return Center(child: Text('No tienes playlist de los usuarios a los que sigues'),);
    } else{
      return Center(
        child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height*.05,
              width: MediaQuery.of(context).size.width*0.5,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    'You don`t follow users',
                    style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ),
      );
    }
  }
}