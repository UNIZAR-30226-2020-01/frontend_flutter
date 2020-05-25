import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/audio/utils/artist.dart';
import 'package:spotiseven/user/tokenSingleton.dart';

class AlbumDAO {
  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static Future<List<Album>> pagedAlbum(int limit, int offset) async {
    print('ilimit: $limit & offset: $offset');
    Response response = await _client.get('$_url/albums/?limit=$limit&offset=$offset',
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
      else return lista.map((dynamic d) => Album.fromJSONListed(d)).toList();
    }
    else {
      throw Exception(
          'Error al buscar playlist Código: ${response.statusCode}'
      );
    }
  }

  static Future<List<Album>> getAllAlbums() async {
    List<dynamic> response =
        await _client.get('$_url/albums', headers: TokenSingleton().authHeader).then((Response resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        throw Exception('No tienes permisos para acceder a este recurso');
      }
    });
//    print(response);
    return response.map((d) => Album.fromJSONListed(d)).toList();
  }

  static Future<Album> getByURL(String url, Artist artist) async {
    return await _client.get('$url', headers: TokenSingleton().authHeader).then((Response response) {
      if (response.statusCode == 200) {
        return Album.fromJSONDetailWithArtist(
            jsonDecode(response.body), artist);
      } else {
        throw Exception('No tienes permisos para acceder a este recurso');
      }
    });
  }

  /// Busca el parámetro en: título o nombre del artista
  static Future<List<Album>> searchAlbum(String query) async {
    Response resp = await _client.get('$_url/albums/?search=$query');
    if(resp.statusCode == 200) {
      // Ha ido bien, devolvemos las listas
      List<dynamic> lista = jsonDecode(utf8.decode(resp.bodyBytes));
      List<Album> albums = lista.map((dynamic d) => (Album.fromJSONListed(d) as Album )).toList();
      return albums;
//      return jsonDecode(utf8.decode(resp.bodyBytes)).map((dynamic d) => Album.fromJSONListed(d)).toList();
    }else{
      throw Exception('La busqueda de Album ha ido mal. Codigo de error ${resp.statusCode}');
    }
  }
}
