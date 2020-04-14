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
    if(favorite){
      // Marcamos como favorita
      Response resp = await _client.get('${song.urlApi}/set_favorite/', headers: TokenSingleton().authHeader);
      if(resp.statusCode != 200) {
        throw Exception('Algo ha ido mal al marcar como favorito. Codigo de error: ${resp.statusCode}');
      }
    }else{
      // Eliminamos como favorita
      Response resp = await _client.get('${song.urlApi}/remove_favorite/', headers: TokenSingleton().authHeader);
      if(resp.statusCode != 200) {
        throw Exception('Algo ha ido mal al marcar como favorito. Codigo de error: ${resp.statusCode}');
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
}
