import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/podcastDAO.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/generic_components/GenericHorizontalListView.dart';
import 'package:spotiseven/generic_components/GenericNewPodChapter.dart';
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

  ScrollController _scrollController;

  bool loading = true;
  @override
  void initState() {
    PodcastDAO.searchPod(9,0,word).then((List<Podcast> list) => setState(() {
          pods = list;
          loading = false;
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
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (!loading && pods != null) {
      return GenericHorizontalListView(
        lista: pods,
      );
    } else {
      return UsefulMethods.noItems(context);
    }
  }
}
