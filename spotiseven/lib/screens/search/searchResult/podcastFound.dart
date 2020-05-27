import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/DAO/podcastDAO.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/generic_components/GenericSmallPodcast.dart';
import 'package:spotiseven/usefullMethods.dart';

class PodcastFound extends StatefulWidget {
  String word;

  PodcastFound({@required this.word});
  @override
  _PodcastFoundState createState() => _PodcastFoundState();
}

class _PodcastFoundState extends State<PodcastFound> {
  String get word => widget.word;
  List<Podcast> pods;

  int items = 4;
  int offset = 0;

  bool fetching = false;

  ScrollController _scrollController;

  bool loading = true;
  @override
  void initState() {
    PodcastDAO.searchPod(18,0,word).then((List<Podcast> list) => setState(() {
          pods = list;
          offset = offset + 18;
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
    if (pods.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {
            if (sn is ScrollEndNotification &&
                sn.metrics.pixels >= 0.7 * sn.metrics.maxScrollExtent && !fetching) {
              fetching = true;
              UsefulMethods.snack(context);
              PodcastDAO.searchPod(items, offset, word).then((List<Podcast> list) {
                if (list.length > 0) {
                  setState(() {
                    print('fetching more items');
                    pods.addAll(list);
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
                crossAxisCount: 3,
                children: pods
                    .map((el) => GenericSmallPodcast(
                  podcast: el,
                ))
                    .toList(),
              ),
            ],
          ));
    }
    else if(pods.isEmpty){
      return UsefulMethods.noItems(context);
    }
    else if (fetching){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
