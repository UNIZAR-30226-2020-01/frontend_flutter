import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/DAO/podcastChapterDAO.dart';
import 'package:spotiseven/audio/utils/DAO/podcastDAO.dart';
import 'package:spotiseven/audio/utils/canalPodcast.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/generic_components/GenericNewPodChapter.dart';
import 'package:spotiseven/screens/artist/artist_info.dart';
import 'package:spotiseven/usefullMethods.dart';

class NewPodcast extends StatefulWidget {
  @override
  _NewPodcastState createState() => _NewPodcastState();
}



class _NewPodcastState extends State<NewPodcast> {
  List<Podcast> _listPodcasts;
  ScrollController _scrollController;
  List<PodcastChapter> _episodios;
  @override
  void initState() {
    _episodios = [];
    _listPodcasts = List();
    _scrollController = ScrollController();
    PodcastDAO.getAllPodcasts().then((List<Podcast> list) {
      setState(() {
      _listPodcasts = list;
      String x = list.map((Podcast p) => p.title).toString();
      print('=========================');
      print(x);

    });
      Podcast p = _listPodcasts.first;
      PodcastDAO.getFromUrl(p.url).then((Podcast p ) => setState(() {
        print('------------');
        print(p.chapters.map((PodcastChapter pc) => pc.title));
        _episodios = p.chapters;
      }));
    });
    super.initState();
  }



  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_episodios == null){
      print('=========================ME CAGO EN TODO');
    }
//    List<PodcastChapter> lista2 = [chap1,chap2,chap3,chap4,chap5,chap6, chap1,chap2,chap3,chap4,chap5,chap6];
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
          _episodios.map((el) => GenericNewPodChapter(
            podcastChapter: el,
          ))
              .toList(),
        ),
      ),
    ],
    );
  }
}
