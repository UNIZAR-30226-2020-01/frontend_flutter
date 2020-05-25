import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/user/tokenSingleton.dart';

class PodcastChapterDAO{
  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static Future<PodcastChapter> getFromUrl(String Url) async {
    dynamic response =
    await _client.get(Url, headers: TokenSingleton().authHeader).then((Response resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        throw Exception('No tienes permisos para acceder a este recurso');
      }
    });
    print(response);
    return PodcastChapter.fromJSON(response);
  }
  static Future<List<PodcastChapter>> searchPodChap(String query) async {
    print('searching podChaps $query');
    Response resp = await _client.get('$_url/podcast-episodes/?search=$query');

    if(resp.statusCode == 200) {
      // Ha ido bien, devolvemos las listas
      List<dynamic> lista = jsonDecode(utf8.decode(resp.bodyBytes));
      List<PodcastChapter> songs = lista.map((dynamic d) => (PodcastChapter.fromJSON(d) as PodcastChapter ))
          .toList();
      return songs;
    }else{
      throw Exception('La busqueda de podcast episodes ha ido mal. Codigo de error ${resp
          .statusCode}');
    }
  }
}