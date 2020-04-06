


import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/generic_components/GenericPodcast.dart';
import 'package:spotiseven/usefullMethods.dart';

class GenericSmallPodcast extends StatelessWidget {
  final Podcast podcast;
 
  GenericSmallPodcast({@required this.podcast});

  @override
  Widget build(BuildContext context) {
    print('Desde small podcast ${podcast.title}');
    return GestureDetector(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) =>
            GenericPodcast(podcast: podcast,),
        ));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            UsefulMethods.imageContainer(context, podcast.photoUrl, 0.2, 0.2),
            SizedBox(height: 10,),
            UsefulMethods.text(podcast.title, 10.0, 0.0, 0, 0, 0, 1.0)
          ],
        )
      ),
    );
  }
}
