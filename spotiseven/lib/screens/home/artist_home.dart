import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/artistDAO.dart';
import 'package:spotiseven/audio/utils/artist.dart';
import 'package:spotiseven/screens/home/details/artist_detail.dart';
import 'package:spotiseven/usefullMethods.dart';

class ArtistScreen extends StatefulWidget {
  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  // Lista de artistas
  var _listArtist = [];

  ScrollController _scrollController;

  int items = 4;
  int offset = 0;

  bool fetching = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    ArtistDAO.pagedArtist(6, 0).then((List<Artist> list) => setState(() {
          _listArtist = list;
          offset = offset + 6;
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
    if (_listArtist.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {
            if (sn is ScrollEndNotification &&
                sn.metrics.pixels >= 0.7 * sn.metrics.maxScrollExtent &&
                !fetching) {
              fetching = true;
              UsefulMethods.snack(context);
              ArtistDAO.pagedArtist(items, offset).then((List<Artist> list) {
                if (list.length > 0) {
                  setState(() {
                    print('fetching more items');
                    _listArtist.addAll(list);
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
              SliverList(
                delegate: SliverChildListDelegate(
                  _listArtist
                      .map((el) => ArtistCardWidget(
                            artista: el,
                          ))
                      .toList(),
                ),
              ),
            ],
          ));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
