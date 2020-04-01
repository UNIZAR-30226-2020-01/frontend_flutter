// Clase Playlist
import 'dart:math';

import 'package:spotiseven/audio/utils/playlist.dart';
// Clase Song
import 'package:spotiseven/audio/utils/song.dart';

// Para controlar la playlist en reproduccion
class PlaylistController {
  // Playlist reproduciendo
  Playlist _playlist;

  // Numero de canciones en la playlist
  int _numSongs;

  // Variable interna de la cuenta
  int _index;

  // TODO: Reproduccion en bucle (POR DEFECTO SE EJECUTA ESTA)


  // Nueva Playlist a reproducir
  PlaylistController(Playlist p) {
    this._playlist = p;
    _index = 0;
    _numSongs = _playlist != null ? _playlist.playlist.length : 0;
    if (_playlist != null) {
      _playlist.playlist.forEach((Song s) => print(s.title));
    }
  }

  // Control de la lista de reproduccion

  // Reproduccion aleatoria
  void random(){
    // Hacemos un shuffle de la lista en reproduccion
    _playlist.playlist.shuffle(Random());
  }

  // Cancion actual
  Song get actualSong {
    if (_playlist == null) {
//      throw Exception('NO HAY COLA DE REPRODUCCION');
      return null;
    }
    return this._playlist.playlist[_index];
  }

  // Poner el iterador del controlador sobre una cancion de la lista
  void setIteratorOn(Song s){
    int index = _playlist.playlist.indexOf(s);
    if(index == -1){
      throw Exception('PlaylistController.setInteratorOn: Cancion no encontrada en la playlist');
    }else{
      _index = index;
    }
  }

  // Playlist actual
  Playlist get actualPlaylist {
    if (_playlist == null) {
      return Playlist()..title = '';
    } else {
      return _playlist;
    }
  }

  set playlist(List<Song> list) => this.actualPlaylist.playlist = list;

  // Pasar a la siguiente cancion
  void next() {
    _index = (_index + 1) % _numSongs;
  }

  // Pasar a la cancion anterior
  void previous() {
    _index = (_index - 1) % _numSongs;
  }
}
