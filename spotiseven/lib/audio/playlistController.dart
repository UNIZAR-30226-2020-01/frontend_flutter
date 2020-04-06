// Clase Playlist
import 'dart:collection';
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

  // Cola de reproduccion
  Queue<Song> _queue;

  // Nueva Playlist a reproducir
  PlaylistController(Playlist p) {
    this._playlist = p;
    _index = 0;
    _numSongs = _playlist != null ? _playlist.playlist.length : 0;
    if (_playlist != null) {
      _playlist.playlist.forEach((Song s) => print(s.title));
      // Convertimos la lista a cola
      _queue = Queue.from(_playlist.playlist);
      // TODO: Podemos borrar la lista de playlist para ahorrar memoria?
    }
  }

  // Control de la lista de reproduccion

  // Reproduccion aleatoria
  void random() {
    // Hacemos un shuffle de la lista en reproduccion
    _queue = Queue.from(_queue.toList()..shuffle(Random()));
  }

  // Cancion actual
  Song get actualSong {
    if (_playlist == null) {
//      throw Exception('NO HAY COLA DE REPRODUCCION');
      return null;
    }
    return this._queue.first;
  }

  // Poner el iterador del controlador sobre una cancion de la lista
  void setIteratorOn(Song s) {
    List<Song> _list = _queue.toList();
    var index = _list.indexOf(s);
    if (index == -1) {
      throw Exception(
          'PlaylistController.setInteratorOn: Cancion no encontrada en la playlist');
    } else {
      _queue = Queue.from(_list..removeAt(index)..insert(0, s));
    }
  }

  // Playlist actual
  Playlist get actualPlaylist {
    if (_playlist == null) {
      return null;
//      return Playlist()..title = '';
    } else {
      // TODO: Si eliminamos la lista de canciones de la playlist -> Añadir
      return _playlist;
    }
  }

  List<Song> get queue => _queue.toList();

  set playlist(List<Song> list) => this.actualPlaylist.playlist = list;

  void moveSong(Song s, int to){
//    print('ANTES: ${_queue.map((Song s) => s.title).toList()}');
    List<Song> _list = _queue.toList();
    int index = _list.indexOf(s);
    if(index == -1){
      throw Exception('Esa cancion no pertenece a la cola de reproduccion!');
    }else{
      // Movemos la cancion
      _list..removeAt(index);
      if(to >= _list.length){
        // Lo insertamos en la posicion final
        _list.insert(_list.length, s);
      }else if(to == 0){
        // Lo insertamos despues de la cancion actual (posicion 0)
        _list.insert(1, s);
      }else{
        // En cualquier otro caso lo insertamos en to + 1(teniendo en cuenta que la cancion actual es la 0)
        _list.insert(to+1, s);
      }
      _queue = Queue.from(_list);
//      print('DESPUES: ${_queue.map((Song s) => s.title).toList()}');
    }
  }

  void addNext(Song s) {
    List<Song> list = _queue.toList();
    _queue = Queue.from(list..insert(1, s));
  }

  // Pasar a la siguiente cancion
  void next() {
//    _index = (_index + 1) % _numSongs;
    _queue.addLast(_queue.removeFirst());
  }

  // Pasar a la cancion anterior
  void previous() {
//    _index = (_index - 1) % _numSongs;
    _queue.addFirst(_queue.removeLast());
  }
}
