import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/DAO/podcastChapterDAO.dart';
import 'package:spotiseven/audio/utils/DAO/podcastDAO.dart';
import 'package:spotiseven/audio/utils/canalPodcast.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/generic_components/GenericPodcast.dart';
import 'package:spotiseven/generic_components/GenericSmallPodcast.dart';
import 'package:spotiseven/generic_components/GenericHorizontalListView.dart';
import 'package:spotiseven/usefullMethods.dart';

class SubscriptionPodcast extends StatefulWidget {
  @override
  _SubscriptionPodcastState createState() => _SubscriptionPodcastState();
}

class _SubscriptionPodcastState extends State<SubscriptionPodcast> {

  List<Podcast> _listPodcasts;
  List<Podcast> _popular;
  bool haySubs;
  bool hayPopulares;
  @override
  void initState() {
    hayPopulares = false;
    haySubs = false;
    _listPodcasts = List();
    PodcastDAO.getAllPodcasts().then((List<Podcast> list) => setState(() {
      _listPodcasts = list;
      haySubs =true;
    }));
    PodcastDAO.getPopular().then((List<Podcast> list) => setState(() {
      _popular=list;
      hayPopulares =true;
    }));
    super.initState();
  }

  _mysubsBar() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: MediaQuery.of(context).size.width * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UsefulMethods.text('MY SUBSCRIPTIONS', 20.0, 0.0, 255,255,255,1.0),
        ],
      ),
    );
  }
  _mysubsItems() {
    if (!hayPopulares){
      return Center (
        child: CircularProgressIndicator(),
      );
    }
    else return GenericHorizontalListView(lista: _listPodcasts,);
  }


  _popularBar() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: MediaQuery.of(context).size.width * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UsefulMethods.text('POPULAR', 20.0, 0.0, 255,255,255,1.0),
        ],
      ),
    );
  }

  _popularItems() {
    if (!hayPopulares){
      return Center (
        child: CircularProgressIndicator(),
      );
    }
    else return GenericHorizontalListView(lista: _popular,);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child:_popularBar(),
            ),Expanded(
              flex: 5,
              child:_popularItems(),
            ),
            Expanded(
              flex: 1,
              child: _mysubsBar(),
            ),
            Expanded(
              flex: 5,
              child: _mysubsItems(),
            ),

          ],
        ),
      ),
    );
  }
}
