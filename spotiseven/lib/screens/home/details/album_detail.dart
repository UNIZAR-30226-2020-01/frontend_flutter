import 'package:flutter/material.dart';
// GenericCardWidget
import 'package:spotiseven/generic_components/GenericCardWidget.dart';
// Clase Album
import 'package:spotiseven/audio/utils/album.dart';

class AlbumCardWidget extends StatelessWidget {

  final Album album;

  AlbumCardWidget({this.album});

  @override
  Widget build(BuildContext context) {
    List<Widget> lista_widget = getStrings().map((String s) => Text(s)).toList();
    return GenericCardWidget(
      // TODO: Imagen del album
      imageUrl: '${album.photoUrl}',
      args: lista_widget,
      // TODO: Integrar con la pantalla de album
      onPressedFunction: () => print('Mostrar pantalla de album'),
    );
  }

  List<String> getStrings() {
    // TODO: Obtener el numero de canciones de un album
    return ['${album.titulo}', '${album.artista}', 'xx songs'];
  }
}
