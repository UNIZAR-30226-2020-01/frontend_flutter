import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/canalPodcast.dart';
import 'package:spotiseven/audio/utils/podcastProgram.dart';
import 'package:spotiseven/generic_components/GenericSmallPodcast.dart';
import 'package:spotiseven/generic_components/GenericHorizontalListView.dart';
import 'package:spotiseven/usefullMethods.dart';

class SubscriptionPodcast extends StatefulWidget {
  @override
  _SubscriptionPodcastState createState() => _SubscriptionPodcastState();
}

class _SubscriptionPodcastState extends State<SubscriptionPodcast> {


  _mysubsBar() {
    return Container(
      color: Colors.black,
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
    return GenericHorizontalListView(lista: mySubs,);
  }



  static Podcast pod = Podcast(
      title: 'RTVE',
      canal: null,
      photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Logo_RTVE.svg/1200px-Logo_RTVE.svg.png',
      numChapters: 1,
      chapters: null);

  static Podcast pod1 = Podcast(
      title: 'RNE',
      canal: null,
      photoUrl: 'https://blob.todoexpertos.com/uploads/md/43d7f49ff9c3ee8c34b5a9c222929a05.jpg',
      numChapters: 1,
      chapters: null);

  static Podcast pod2 = Podcast(
      title: 'COPE',
      canal: null,
      photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Logo_RTVE.svg/1200px-Logo_RTVE.svg.png',
      numChapters: 1,
      chapters: null);

  static Podcast pod3 = Podcast(
      title: 'CADENA SER',
      canal: null,
      photoUrl: 'https://blob.todoexpertos.com/uploads/md/43d7f49ff9c3ee8c34b5a9c222929a05.jpg',
      numChapters: 1,
      chapters: null);
  List<Podcast> liveList = [pod, pod1, pod2, pod3, pod, pod1, pod2, pod3];

  _liveBar() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: MediaQuery.of(context).size.width * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UsefulMethods.text('LIVE', 14.0, 0.0, 255,255,255,1.0),
        ],
      ),
    );
  }


  _liveBarItems() {
    return GenericHorizontalListView(lista: liveList,);
  }

  _popularBar() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: MediaQuery.of(context).size.width * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UsefulMethods.text('POPULAR', 14.0, 0.0, 255,255,255,1.0),
        ],
      ),
    );
  }

  _popularItems() {
    return GenericHorizontalListView(lista: liveList,);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 1,
            child: _mysubsBar(),
          ),
          Expanded(
            flex: 5,
            child: _mysubsItems(),
          ),

          Expanded(
              flex: 1,
              child:_liveBar(),
          ),
          Expanded(
              flex: 5,
              child: _liveBarItems(),
          ),
          Expanded(
              flex: 1,
              child:_popularBar(),
          ),Expanded(
              flex: 5,
              child:_popularItems(),
          ),
        ],
      ),
    );
  }
}
