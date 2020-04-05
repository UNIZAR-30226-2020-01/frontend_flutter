import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/canalPodcast.dart';
import 'package:spotiseven/audio/utils/podcastProgram.dart';
import 'package:spotiseven/generic_components/GenericSmallPodcast.dart';
import 'package:spotiseven/usefullMethods.dart';

class SubscriptionPodcast extends StatefulWidget {
  @override
  _SubscriptionPodcastState createState() => _SubscriptionPodcastState();
}

class _SubscriptionPodcastState extends State<SubscriptionPodcast> {


  _mysubsBar() {
    return Container(
      color: Colors.black,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: MediaQuery.of(context).size.width * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UsefulMethods.text('MY SUBSCRIPTIONS', 14.0, 0.0, 255,255,255,1.0),
        ],
      ),
    );
  }

  static final canal1 = CanalPodcast(title: 'RTVE', author: 'Españita',
  photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Logo_RTVE.svg/1200px-Logo_RTVE.svg.png');
  Podcast noticias = Items.pod1(canal1, 'noticas', 8 , 'https://static.foxnews.com/static/orion/styles/img/fox-news/og/og-fox-news.png');
  Podcast deportes = Items.pod1(canal1, 'deporte', 8, 'https://conceptodefinicion.de/wp-content/uploads/2016/09/Deporte2.jpg');
  Podcast politica = Items.pod1(canal1, 'politica', 9, 'https://blob.todoexpertos.com/uploads/md/43d7f49ff9c3ee8c34b5a9c222929a05.jpg');

  Podcast ninos = Items.pod1(canal1, 'Niños', 3, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg');

  static List<Podcast> mySubs= [];
  _SubscriptionPodcastState(){
    mySubs.add(noticias);
    mySubs.add(deportes);
    mySubs.add(politica);
    mySubs.add(ninos);
    mySubs.add(noticias);
    mySubs.add(deportes);
    mySubs.add(politica);
    mySubs.add(ninos);
  }
  _mysubsItems() {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
      child: ListView.builder(
          itemCount: mySubs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return GenericSmallPodcast(podcast: mySubs[index],);
          }
      ),
    );
  }

  _liveBar() {
    return Container(
      height: 10,
    );
  }

  _liveBarItems() {
    return Container(
      height: 10,
    );
  }

  _popularBar() {
    return Container(
      height: 10,
    );
  }

  _popularItems() {
    return Container(
      height: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _mysubsBar(),
          _mysubsItems(),
          SizedBox(
            height: 10,
          ),
          _liveBar(),
          _liveBarItems(),
          _popularBar(),
          _popularItems(),
        ],
      ),
    );
  }
}
