import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/user/tokenSingleton.dart';
import 'package:spotiseven/user/user.dart';

class SongDAO {
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static final Client _client = Client();

  static Future<List<Song>> getAllSongs() async {
    List<dynamic> response = jsonDecode((await _client.get('$_url/songs', headers: TokenSingleton().authHeader)).body);
    return response.map((d) => Song.fromJSON(d));
  }

  static Future<void> markAs(bool favorite, Song song) async {
    // TODO: Validar
    print(' --- URL: ${song.urlApi}');
    print(' --- Favorite: $favorite');
    if(favorite){
      // Marcamos como favorita
      Response resp = await _client.get('${song.urlApi}set_favorite/', headers: TokenSingleton().authHeader);
      if(resp.statusCode != 200) {
        throw Exception('Algo ha ido mal al marcar como favorito. Codigo de error: ${resp.statusCode}');
      }
    }else{
      // Eliminamos como favorita
      Response resp = await _client.get('${song.urlApi}remove_favorite/', headers: TokenSingleton().authHeader);
      if(resp.statusCode != 200) {
        throw Exception('Algo ha ido mal al DESMARCAR como favorito. Codigo de error: ${resp.statusCode}');
      }
    }
  }

  static Future<Song> getByUrl(String url) async {
    Response response = await _client.get('$url', headers: TokenSingleton().authHeader);
    if(response.statusCode == 200){
      // Ha ido bien
      return Song.fromJsonDetail(jsonDecode(response.body));
    }else{
      // Error
      throw Exception('La busqueda de URL(SONG) ha fallado. Codigo de error: ${response.statusCode}');
    }
  }

  /// Busca el parámetro en: título o nombre del artista

  static Future<List<Song>> searchSong(int limit, int offset, String query) async {
      print('searching podChaps $query');
      Response resp = await _client.get('$_url/songs/?search=$query&limit=$limit&offset=$offset'
          '=$offset', headers: TokenSingleton().authHeader);

      if(resp.statusCode == 200) {
        Map<String, dynamic> map = (jsonDecode(utf8.decode(resp.bodyBytes)) as Map);
        List<dynamic> lista = map['results'];
        if (map['next'] == null && lista.isEmpty){
          //=======================================
          // DEVOLVEMOS NULL PQ SE HAN ACABADO LOS RECURSOS DE LA PAGINACIÓN
          // SOMOS UNOS GUARRROS
          //=======================================
          return [];
        }
        else return lista.map((dynamic d) => Song.fromJSON(d)).toList();
      }
      else {
        throw Exception('La busqueda de Artist ha ido mal. Codigo de error ${resp.statusCode}');
      }
    }


//  static Future<List<Song>> searchSong(String query) async {
//    Response resp = await _client.get('$_url/songs/?search=$query');
//    if(resp.statusCode == 200) {
//      // Ha ido bien, devolvemos las listas
//      List<dynamic> lista = jsonDecode(utf8.decode(resp.bodyBytes));
//      List<Song> songs = lista.map((dynamic d) => (Song.fromJSON(d) as Song )).toList();
//      return songs;
//    }else{
//      throw Exception('La busqueda de Song ha ido mal. Codigo de error ${resp.statusCode}');
//    }
//  }


  static Future<List<Song>> mostPlayed(int limit, int offset) async {
    print('ilimit: $limit & offset: $offset');
    Response response = await _client.get
      ('$_url/songs/?ordering=-times_played&limit=$limit&offset=$offset',
        headers: TokenSingleton().authHeader);
    if (response.statusCode == 200) {
      print('RESPONSE: ${response.body}');
      Map<String, dynamic> map = (jsonDecode(utf8.decode(response.bodyBytes)) as Map);
      List<dynamic> lista = map['results'];
      print(lista);
      if (map['next'] == null && lista.isEmpty){
        //=======================================
        // DEVOLVEMOS NULL PQ SE HAN ACABADO LOS RECURSOS DE LA PAGINACIÓN
        // SOMOS UNOS GUARRROS
        //=======================================
        return [];
      }
      else return lista.map((dynamic d) => Song.fromJSON(d)).toList();
    }
    else {
      throw Exception(
          'Error al buscar playlist Código: ${response.statusCode}'
      );
    }
  }
}
