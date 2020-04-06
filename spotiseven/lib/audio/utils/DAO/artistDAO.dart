import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/artist.dart';

class ArtistDAO {
  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static Future<List<Artist>> getAllArtist() async {
    List<Artist> list =
        await _client.get('$_url/artists/').then((Response response) {
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
//    return await _client.get('$url').then((Response response) {
//      if(response.statusCode == 200){
//        return Artist.fromJSONDetail(jsonDecode(response.body));
//      }else{
//        throw Exception('No tienes permisos para acceder a este recurso');
//      }
//    });
    // TODO: Comprobar que funcione
    Response response = await _client.get('$url');
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      return Artist.fromJSONDetail(map);
    } else {
      throw Exception('No tienes permisos para acceder a este recurso');
    }
  }
}
