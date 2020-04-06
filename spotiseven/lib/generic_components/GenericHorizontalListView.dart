import 'package:flutter/material.dart';
import 'package:spotiseven/generic_components/GenericSmallPodcast.dart';
import 'package:spotiseven/usefullMethods.dart';

class GenericHorizontalListView extends StatelessWidget {
  List<Object> lista;

  GenericHorizontalListView({@required this.lista});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: ListView.builder(
          itemCount: lista.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return GenericSmallPodcast(podcast: lista[index],);
          }
      ),
    );
  }
}
