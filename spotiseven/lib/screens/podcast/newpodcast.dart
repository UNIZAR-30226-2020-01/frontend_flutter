import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/generic_components/GenericNewPodcast.dart';
import 'package:spotiseven/screens/artist/artist_info.dart';

class NewPodcast extends StatefulWidget {
  @override
  _NewPodcastState createState() => _NewPodcastState();
}
class _NewPodcastState extends State<NewPodcast> {

  static PodcastChapter pod1 = PodcastChapter(
    title: 'Noticias covid',
    parentPod: 'RTVE',
    description: 'noticias de covid y demás noticias de covid y demás'
        'noticias de covid y demás noticias de covid y demás noticias de covid y demás'
        'noticias de covid y demás noticias de covid y demás noticias de covid y demás'
        'noticias de covid y demás noticias de covid y demás noticias de covid y demás'
        'noticias de covid y demás noticias de covid y demás noticias de covid y demás 1000000'
        'noticias de covid y demás noticias de covid y demás noticias de covid y demás'
        'noticias de covid y demás noticias de covid y demás noticias de covid y demás'
        'noticias de covid y demás noticias de covid y demás noticias de covid y demás',
    duration: '1h:30',
    date: '19 de marzo de 2020',
    photoUrl: 'https://ewscripps.brightspotcdn.com/dims4/default/7671677/2147483647/strip/true/crop/1303x733+15+0/resize/1280x720!/quality/90/?url=https%3A%2F%2Fewscripps.brightspotcdn.com%2F0a%2Ff2%2F72b1b4d94794992a0772cb593ce5%2Fscreen-shot-2020-02-25-at-10.49.27%20AM.png'
  );

  static PodcastChapter pod2 = PodcastChapter(
    title: 'Flutter ',
    parentPod: 'Google',
    description: 'como desarrollar en flutter como desarrollar en flutter'
        'como desarrollar en flutter como desarrollar en flutter como desarrollar en flutter'
        'como desarrollar en flutter como desarrollar en flutter como desarrollar en flutter'
        'como desarrollar en flutter como desarrollar en flutter como desarrollar en flutter',
    duration: '3h',
    date: '29 de marzo de 2020',
    photoUrl: 'https://flutter-es.io/assets/homepage/news-2-599aefd56e8aa903ded69500ef4102cdd8f988dab8d9e4d570de18bdb702ffd4.png'
  );


  var _listaPodcast = [
    pod1,
    pod2,
    pod1,
    pod2,
    pod1,
    pod2,
    pod1,
    pod2
  ];

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
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
          _listaPodcast
              .map((el) => GenericNewPodcast(
            podcastChapter: el,
          ))
              .toList(),
        ),
      ),
    ],
    );
  }
}
