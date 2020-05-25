import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/artist.dart';
import 'package:spotiseven/user/tokenSingleton.dart';

class ArtistDAO {
  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static Future<List<Artist>> pagedArtist(int limit, int offset) async {
    print('ilimit: $limit & offset: $offset');
    Response response = await _client.get('$_url/artists/?limit=$limit&offset=$offset',
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
      else return lista.map((dynamic d) => Artist.fromJSONListed(d)).toList();
    }
    else {
      throw Exception(
          'Error al buscar playlist Código: ${response.statusCode}'
      );
    }
  }

  static Future<List<Artist>> getAllArtist() async {
    List<Artist> list =
        await _client.get('$_url/artists/', headers: TokenSingleton().authHeader).then((Response response) {
      if (response.statusCode == 200) {
        // TODO: Cambiar esto con la version final (comprobar el fromJSON)
        return (jsonDecode(response.body) as List)
            .map((d) => Artist.fromJSONListed(d))
            .toList();
      } else {
        throw Exception('No tienes permiso para acceder a este recurso');
      }
    });
    return list;
  }

  // Peticion a la URL del recurso del artista
  static Future<Artist> getByURL(String url) async {
    // TODO: Comprobar que funcione
    Response response = await _client.get('$url', headers: TokenSingleton().authHeader);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return Artist.fromJSONDetail(map);
    } else {
      throw Exception('No tienes permisos para acceder a este recurso');
    }
  }

  /// Busca el parámetro en: nombre del artista
  static Future<List<Artist>> searchArtist(String query) async {
    print('searching artists $query');
    Response resp = await _client.get('$_url/artists/?search=$query');
    if(resp.statusCode == 200) {
      // Ha ido bien, devolvemos las listas
      List<dynamic> lista = jsonDecode(utf8.decode(resp.bodyBytes));
      List<Artist> artists = lista.map((dynamic d) => (Artist.fromJSONListed(d) as Artist )).toList();
      return artists;
//      return jsonDecode(utf8.decode(resp.bodyBytes)).map((dynamic d) => Artist.fromJSONListed(d)).toList();
    }else{
      throw Exception('La busqueda de Artist ha ido mal. Codigo de error ${resp.statusCode}');
    }
  }
}
