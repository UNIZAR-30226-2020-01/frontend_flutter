import 'package:flutter/material.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/generic_components/GenericHoriSong.dart';


class SongCardWidget extends StatelessWidget {

  final Song song;

  SongCardWidget({this.song}){
    print(this.song.title);
}

  @override
  Widget build(BuildContext context) {
    //List<Widget> lista_widget = getStrings().map((String s) => Text(s)).toList();
    return GenericHoriSong(
      // TODO: Imagen del album
      imageUrl: '${song.photoUrl}',
      s: song,
      args: getStrings(),
      // TODO: Integrar con la pantalla de album
      onPressedFunction: () {
        var playingSingleton = PlayingSingleton();
        playingSingleton.addSongNext(song);
        playingSingleton.next();
//        playingSingleton.play(song);
        print('Reproduciendo ' + song.title);
      },
    );
  }

  List<String> getStrings() {
    // TODO: Obtener el numero de canciones de un album
    return [
      song.title.toString(),
      song.album.artista.name.toString(),
      song.album.toString(),
    ];
    //return ['${album.titulo}', '${album.artista.name}', '${album.numberSongs} songs'];
  }
}
