import 'package:flutter/material.dart';
import 'package:spotiseven/generic_components/GenericSmallPodcast.dart';
import 'package:spotiseven/generic_components/genericSmallUser.dart';
import 'package:spotiseven/usefullMethods.dart';
import 'package:spotiseven/user/user.dart';

class GenericElementList extends StatelessWidget {
  List<User> lista;

  GenericElementList({@required this.lista}){
    print('Entro generic element list');
  }

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
            print('Desde generichorizontallistview podcast es ${lista.first}');

            return GenericSmallUser(user: lista[index],);
          }
      ),
    );
  }
}
