import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/generic_components/GenericCardWidget.dart';
import 'package:spotiseven/screens/album/album_screen.dart';
import 'package:spotiseven/usefullMethods.dart';

class AlbumCardWidget extends StatelessWidget {

  final Album album;

  AlbumCardWidget({this.album});

  @override
  Widget build(BuildContext context) {
    //List<Widget> lista_widget = getStrings().map((String s) => Text(s)).toList();
    return GenericCardWidget(
      // TODO: Imagen del album
      imageUrl: '${album.photoUrl}',
      args: getStrings(),
      // TODO: Integrar con la pantalla de album
      onPressedFunction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumDetailScreen(album: album,))),
    );
  }

  List<Widget> getStrings() {
    // TODO: Obtener el numero de canciones de un album
    return [
      UsefulMethods.text(album.titulo.toString(), 10.0, 0.0, 255,255, 255, 1.0),
      UsefulMethods.text(album.artista.name.toString(), 10.0, 0.0, 255,255, 255, 1.0),
      UsefulMethods.text(album.numberSongs.toString()+' songs', 10.0, 0.0, 255,255, 255, 1.0),
    ];
    //return ['${album.titulo}', '${album.artista.name}', '${album.numberSongs} songs'];
  }
}
