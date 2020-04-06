import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:spotiseven/audio/utils/DAO/albumDAO.dart';
// Clase Song
import 'package:spotiseven/audio/utils/song.dart';
// Clase Artist
import 'package:spotiseven/audio/utils/artist.dart';
// Clase ArtistDAO
import 'package:spotiseven/audio/utils/DAO/artistDAO.dart';

// TODO: Cambiar esto para que coincida con los campos de la BD.
class Album {
  // URL del recurso
  String url;

  // Titulo
  String titulo;

  // Artista principal
  Artist artista;

  // Artistas colaboradores
  List<String> colaboradores;

  // TODO: Comprobar la eficiencia de no tener esto siempre cargado en memoria.
  // Lista de canciones
  List<Song> list;

  // Numero de canciones
  int numberSongs;

  // Foto del album
  String photoUrl;

  // Constructor
  Album(
      {this.url,
      this.titulo,
      this.artista,
      this.photoUrl,
      this.colaboradores,
      this.numberSongs}) {
    list = List();
  }

  static Album fromJSONListed(Map<String, Object> json) {
    Album a = Album(
      url: json['url'],
      titulo: json['title'],
      // TODO: Comprobar si funciona
      artista: Artist.fromJSONListed(json['artist']),
      photoUrl: json['icon'],
      numberSongs: json['number_songs'],
    );
    return a;
  }

  static Album fromJSONListedWithArtist(Map<String, Object> json, Artist artist) {
    Album a = Album(
      url: json['url'],
      titulo: json['title'],
      // TODO: Comprobar si funciona
      artista: artist,
      photoUrl: json['icon'],
      numberSongs: json['number_songs'],
    );
    return a;
  }

  // TODO: Cambiar esto para que coincida con la API REST
  static Album fromJSONDetailWithArtist(Map<String, Object> json, Artist artist) {
    List<String> colaborators = List();
    if (json['other_artists'] != null &&
        (json['other_artists'] as List) != List()) {
      colaborators = (json['other_artists'] as List)
          .map((d) => ((d as Map)['name'] as String))
          .toList();
    }
    Album a = Album(
      url: json['url'],
      titulo: json['title'],
      // TODO: Comprobar si funciona
      artista: artist,
      colaboradores: colaborators,
      photoUrl: json['icon'],
      numberSongs: json['number_songs'],
    );
    if (json.containsKey('songs')) {
      a.list = (json['songs'] as List).map((j) => Song.fromJSONWithAlbum(j,a)).toList();
      // Mapeamos el album para las canciones
      a.list = a.list.map((Song s) => s..album = a).toList();
    } else {
      a.list = List();
    }
    return a;
  }

  Future<void> fetchRemote() async {
    var album = await AlbumDAO.getByURL(url, artista);
    print(album.titulo);
    // Actualizamos los campos
    titulo = album.titulo;
    list = album.list;
  }

}
