import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/playlistDAO.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/screens/home/details/playlist_detail.dart';
import 'package:spotiseven/usefullMethods.dart';

class PlaylistsScreen extends StatefulWidget {
  @override
  _PlaylistsScreenState createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  List<Playlist> _listPlaylist;

  ScrollController _scrollController;

  int items = 4;
  int offset = 0;

  bool fetching = false;

  @override
  void initState() {
    _listPlaylist = List();
    PlaylistDAO.pagedPlaylist(8, 0).then((List<Playlist> list) => setState(() {
          _listPlaylist = list;
          offset = offset + 8;
        }));
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_listPlaylist.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification sn) {
          if (sn is ScrollEndNotification &&
              sn.metrics.pixels >= 0.7 * sn.metrics.maxScrollExtent && !fetching) {
            fetching = true;
            UsefulMethods.snack(context);
            PlaylistDAO.pagedPlaylist(items, offset).then((List<Playlist> list) {
              if (list.length > 0) {
                setState(() {
                  print('fetching more items');
                  _listPlaylist.addAll(list);
                  offset = offset + items;
                  fetching= false;
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
              children: _listPlaylist
                  .map((el) => PlaylistCardWidget(
                        playlist: el,
                      ))
                  .toList(),
            ),
          ],
        ),
      );
    }
    else if(_listPlaylist == null){
      return UsefulMethods.noItems(context);
    }
    else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
