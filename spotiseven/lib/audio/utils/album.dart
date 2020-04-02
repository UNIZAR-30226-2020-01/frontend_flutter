
import 'dart:convert';
import 'package:spotiseven/audio/utils/albumDAO.dart';
// Clase Song
import 'package:spotiseven/audio/utils/song.dart';

// TODO: Cambiar esto para que coincida con los campos de la BD.
class Album {

  // URL de peticiones
  String url;

  // Titulo
  String titulo;

  // Artista principal
  String artista;

  // TODO: Artistas colaboradores (relacion 1:N)
  List<String> colaboradores;

  // TODO: Comprobar la eficiencia de no tener esto siempre cargado en memoria.
  // Lista de canciones
  List<Song> list;

  // Numero de canciones
  int numberSongs;

  // Foto del album
  String photoUrl;

  // Constructor
  Album({this.url, this.titulo, this.artista, this.photoUrl, this.colaboradores, this.numberSongs}){
    list = List();
  }

  // TODO: Cambiar esto para que coincida con la API REST
  factory Album.fromJSON(Map<String, Object> json) {
//    print('ARTISTA: ${((json['artists'] as List)[0] as Map)['name']}');
    Album a = Album(
        url: json['url'],
        titulo: json['title'],
        // TODO: Esto es una modificacion para mostrar solo el nombre de un artista
        artista: ((json['artists'] as List)[0] as Map)['name'],
        photoUrl: json['icon'],
        numberSongs: json['number_songs'],
    )..list = json['songs'] != null ? (json['songs'] as  List).map((j) => Song.fromJSON(j)).toList() : List();
    a.list = a.list.map((Song s) => s..album = a).toList();
    return a;
  }

  Future<void> fetchRemote() async {
    var album = await AlbumDAO.getByURL(url);
    print(album.titulo);
    // Actualizamos los campos
    titulo = album.titulo;
    list = album.list;
  }
}
