import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/DAO/podcastDAO.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/generic_components/GenericPodcast.dart';
import 'package:spotiseven/usefullMethods.dart';

class GenericSmallPodcast extends StatelessWidget {
  Podcast podcast;
  Podcast p_detallado;
 
  GenericSmallPodcast({@required this.podcast}){
    coger();
  }

  Future<Podcast> coger() async{
    p_detallado =  await PodcastDAO.getFromUrl(podcast.url);
    return p_detallado;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) {
          print("Chapters:" + p_detallado.chapters.toString());
          return GenericPodcast(podcast: p_detallado,);
        },
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
