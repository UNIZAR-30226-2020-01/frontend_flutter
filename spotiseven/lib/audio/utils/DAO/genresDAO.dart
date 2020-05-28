
import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/genres.dart';

class GenresDAO {
  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static Future<List<Genres>> searchGenres(int items, int offset) async {
    Response resp = await _client.get
      ('$_url/genres/?ordering=-number_podcasts&items=$items&offset=$offset');
    if(resp.statusCode == 200) {
      // Ha ido bien, devolvemos las listas
      List<dynamic> lista = jsonDecode(utf8.decode(resp.bodyBytes));
      List<Genres> genres = lista.map((dynamic d) => Genres.fromJSON(d) ).toList();
      return genres;
    }else{
      throw Exception('La busqueda de genres ha ido mal. Codigo de error ${resp.statusCode}');
    }
  }

}
