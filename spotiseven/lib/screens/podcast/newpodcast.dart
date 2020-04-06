import 'package:flutter/material.dart';
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


  static CanalPodcast canal1 = CanalPodcast(title: 'RTVE', author: 'ESPAÑITA', photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Logo_RTVE.svg/1200px-Logo_RTVE.svg.png');

  static Podcast pod = Items.pod1(canal1, 'noticias', 6, 'https://static.foxnews.com/static/orion/styles/img/fox-news/og/og-fox-news.png');
  PodcastChapter chap1 = Items.ch1(pod);
  PodcastChapter chap2 = Items.ch1(pod);
  PodcastChapter chap3 = Items.ch1(pod);
  PodcastChapter chap4 = Items.ch2(pod);
  PodcastChapter chap5 = Items.ch2(pod);
  PodcastChapter chap6 = Items.ch2(pod);


   List<PodcastChapter> lista1 = Items.devoLists(pod);

   static List<PodcastChapter> lista2 = Items.devoLists(pod);
   Podcast pod2 = Items.addChapters(pod, lista2);


  ScrollController _scrollController;

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
    List<PodcastChapter> lista2 = [chap1,chap2,chap3,chap4,chap5,chap6, chap1,chap2,chap3,chap4,chap5,chap6];
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
          lista2.map((el) => GenericNewPodChapter(
            podcastChapter: el,
          ))
              .toList(),
        ),
      ),
    ],
    );
  }
}
