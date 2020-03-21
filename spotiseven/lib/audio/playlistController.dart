// Clase Playlist
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

  // TODO: Reproduccion en bucle
  // TODO: Reproduccion aleatoria
  // TODO: Encapsular comportamientos extraños con excepciones

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

  // Cancion actual
  Song get actualSong {
    if (_playlist == null) {
//      throw Exception('NO HAY COLA DE REPRODUCCION');
      return null;
    }
    return this._playlist.playlist[_index];
  }

  // Playlist actual
  Playlist get actualPlaylist {
    if (_playlist == null) {
      return Playlist()..title = '';
    } else {
      return _playlist;
    }
  }

  // Pasar a la siguiente cancion
  void next() {
    print('Index pre-incremento: $_index');
//    _index = _index == _numSongs - 1? 0 : _index ++;
    _index = (_index + 1) % _numSongs;
    print('Index post-incremento: $_index');
  }

  // Pasar a la cancion anterior
  void previous() {
    _index = _index > 0 ? _index-- : _numSongs - 1;
  }
}
