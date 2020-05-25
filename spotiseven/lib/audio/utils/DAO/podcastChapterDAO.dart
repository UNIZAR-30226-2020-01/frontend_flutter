import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/DAO/podcastDAO.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
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



  static Future<List<PodcastChapter>> searchPodChap(int limit, int offset, String query) async {
    print('searching podChaps $query');
    Response resp = await _client.get('$_url/podcast-episodes/?search=$query&limit=$limit&offset'
        '=$offset');
    Podcast p;

    if(resp.statusCode == 200) {
      Map<String, dynamic> map = (jsonDecode(utf8.decode(resp.bodyBytes)) as Map);
      List<dynamic> lista = map['results'];
      p = await PodcastDAO.getFromUrl(map['AQUI URL DEL POD PADRE']);
      if (map['next'] == null && lista.isEmpty){
        //=======================================
        // DEVOLVEMOS NULL PQ SE HAN ACABADO LOS RECURSOS DE LA PAGINACIÓN
        // SOMOS UNOS GUARRROS
        //=======================================
        return [];
      }
      else {
        return lista.map((dynamic d) => (PodcastChapter.fromJSONwithPodcast(d,p)) as PodcastChapter)
          .toList();
      }
    }
    else {
      throw Exception('La busqueda de episodios de podcast ha ido mal. Codigo de error ${resp
          .statusCode}');
    }
  }
}