import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/genres.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/generic_components/GenericSmallPodcast.dart';

class PodFromGenre extends StatefulWidget {
  List<Podcast> pods;
  Genres g;

  PodFromGenre({this.pods, this.g});
  @override
  _PodFromGenreState createState() => _PodFromGenreState();
}

class _PodFromGenreState extends State<PodFromGenre> {
  List<Podcast> get pods => widget.pods;
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GÉNERO: ${widget.g.name}'
        ),
      ),
        body: CustomScrollView(
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
}
