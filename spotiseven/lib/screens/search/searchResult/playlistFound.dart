import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/playlistDAO.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/screens/home/details/playlist_detail.dart';
import 'package:spotiseven/usefullMethods.dart';

class PlaylistFound extends StatefulWidget {
  final List<Playlist> foundpl;
  String word;
  bool vacio;
  PlaylistFound({@required this.foundpl, @required this.word}){
    vacio = false;
  }

  @override
  _PlaylistFoundState createState() => _PlaylistFoundState();
}

class _PlaylistFoundState extends State<PlaylistFound> {
  List<Playlist> get foundlp => widget.foundpl;
  String get word => widget.word;
  ScrollController _scrollController;

  int items = 4;
  int offset = 8;

  bool fetching = false;
  bool get vacio => widget.vacio;

  @override
  void initState() {
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
    if (offset==0){
      print(' song $fetching');
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else if (foundlp.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {
            if (sn is ScrollEndNotification &&
                sn.metrics.pixels >= 0.7 * sn.metrics.maxScrollExtent &&
                !fetching) {
              fetching = true;
              UsefulMethods.snack(context);
              PlaylistDAO.searchPlaylist(items, offset, word).then((List<Playlist> list) {
                if (list.length > 0) {
                  setState(() {
                    print('fetching more items');
                    foundlp.addAll(list);
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
                children: widget.foundpl
                    .map((el) => PlaylistCardWidget(
                          playlist: el,
                        ))
                    .toList(),
              ),
            ],
          ));
    }
    else if (vacio){
      return UsefulMethods.noItems(context);
    }
    else
      return UsefulMethods.noItems(context);
  }
}
