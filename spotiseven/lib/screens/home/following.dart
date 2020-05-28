import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/playlistDAO.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/screens/home/details/playlist_detail.dart';
import 'package:spotiseven/usefullMethods.dart';
import 'package:spotiseven/user/userDAO.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  bool _initialized;

  List<Playlist> _followingUserPlaylist;

  ScrollController _scrollController;

  int items = 4;
  int offset = 0;

  bool fetching = false;

  @override
  void initState() {
    _initialized = false;
    _followingUserPlaylist = List();
    _scrollController = ScrollController();
    UserDAO.followingPlaylists(8, 0).then((List<Playlist> lp) => setState(() {
          _initialized = true;
          _followingUserPlaylist = lp;
          offset = offset + 8;
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
    if (_followingUserPlaylist.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {
            if (sn is ScrollEndNotification &&
                sn.metrics.pixels >= 0.7 * sn.metrics.maxScrollExtent &&
                !fetching) {
              fetching = true;
              UsefulMethods.snack(context);
              UserDAO.followingPlaylists(items, offset).then((List<Playlist> list) {
                if (list.length > 0) {
                  setState(() {
                    print('fetching more items');
                    _followingUserPlaylist.addAll(list);
                    offset = offset + items;
                    fetching = false;
                  });
                }
              });
            }
            return true;
          },
          child: CustomScrollView(
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
          ));
    } else if (_followingUserPlaylist == null) {
      return UsefulMethods.noItems(context);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
