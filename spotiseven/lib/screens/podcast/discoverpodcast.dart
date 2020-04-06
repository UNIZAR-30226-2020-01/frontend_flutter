import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/audio/utils/podcastProgram.dart';
import 'package:spotiseven/generic_components/GenericHorizontalListView.dart';
import 'package:spotiseven/usefullMethods.dart';

class DiscoverPodcast extends StatefulWidget {
  @override
  _DiscoverPodcastState createState() => _DiscoverPodcastState();
}




class _DiscoverPodcastState extends State<DiscoverPodcast> {


  _foruBar() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: MediaQuery.of(context).size.width * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UsefulMethods.text('FOR YOU', 14.0, 0.0, 255,255,255,1.0),
        ],
      ),
    );
  }



  _foruElem() {
    List<Podcast> list = Items.devoListsPodcasts();
    return GenericHorizontalListView(lista: list,);
  }

  _suggestionsBar() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: MediaQuery.of(context).size.width * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UsefulMethods.text('SUGGESTIONS', 14.0, 0.0, 255,255,255,1.0),
        ],
      ),
    );
  }


  suggestion(title){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UsefulMethods.suggestionImage(context, 'https://cdn.pixabay.com/photo/2019/06/26/18/00/suggestion-4300902_1280.jpg',
              0.4, 0.2),
          UsefulMethods.text(title, 15.0, 0.0, 0, 0, 0, 1.0)
        ],
      ),
    );
  }



  _suggestionsGrid() {
    List<Podcast> list = Items.devoListsPodcasts();
    return Container(
      child: GridView.builder(
        itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: suggestion(list[index].title),
            );
          }

      )
    );
  }





  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _foruBar(),
          ),
          Expanded(
            flex: 4,
            child: _foruElem(),
          ),
          Expanded(
            flex: 1,
            child: _suggestionsBar(),
          ),
          Expanded(
            flex: 10,
            child: _suggestionsGrid(),
          )
        ],
      ),
    );
  }
}




