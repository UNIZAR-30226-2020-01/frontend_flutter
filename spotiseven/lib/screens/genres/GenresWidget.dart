import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/genres.dart';
import 'package:spotiseven/screens/genres/GenresWidgetItem.dart';

class GenresWidget extends StatelessWidget {
  List<Genres> lista;

  GenresWidget({@required this.lista});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(
                lista.length,
                (index) => GenresWidgetItem(
                      g: lista[index],
                    ))));
  }
}
