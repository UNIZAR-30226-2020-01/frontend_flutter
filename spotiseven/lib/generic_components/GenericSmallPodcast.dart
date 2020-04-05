


import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/podcastProgram.dart';
import 'package:spotiseven/usefullMethods.dart';

class GenericSmallPodcast extends StatelessWidget {
  final Podcast podcast;

  GenericSmallPodcast({@required this.podcast});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          UsefulMethods.imageContainer(context, podcast.photoUrl, 0.2, 0.2),
          SizedBox(height: 10,),
          UsefulMethods.text(podcast.title, 10.0, 0.0, 0, 0, 0, 1.0)
        ],
      )
    );
  }
}
