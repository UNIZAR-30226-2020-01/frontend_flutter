import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/DAO/podcastDAO.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/generic_components/GenericPodcast.dart';
import 'package:spotiseven/usefullMethods.dart';

class GenericSmallPodcast extends StatefulWidget {
  Podcast podcast;

  GenericSmallPodcast({@required this.podcast});

  @override
  _GenericSmallPodcastState createState() => _GenericSmallPodcastState();
}

class _GenericSmallPodcastState extends State<GenericSmallPodcast> {
  Podcast p_detallado;

  @override
  void initState(){
    coger();
    super.initState();
  }

  Future<Podcast> coger() async{
    print(widget.podcast.title + '  ' + widget.podcast.id.toString());
    if (widget.podcast.url == null) {
      print('es un trending');
      p_detallado = await PodcastDAO.getTrending(widget.podcast.id);
    }
    else {
      p_detallado= await PodcastDAO.getFromUrl(widget.podcast.url);
      print('no es trending');
    }
      return p_detallado;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) {
          print("Chapters:" + p_detallado.chapters.length.toString());
          print(p_detallado.chapters[1].title);
          return GenericPodcast(podcast: p_detallado,);
        },
        ));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            UsefulMethods.imageContainer(context, widget.podcast.photoUrl, 0.2, 0.2),
            SizedBox(height: 10,),
            UsefulMethods.text(widget.podcast.title, 10.0, 0.0, 0, 0, 0, 1.0)
          ],
        )
      ),
    );
  }
}
