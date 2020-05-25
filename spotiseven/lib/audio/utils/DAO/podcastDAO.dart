import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/user/tokenSingleton.dart';

class PodcastDAO{
  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static Future<List<Podcast>> getUserPods() async {
    List<dynamic> response =
    await _client.get('$_url/user/podcasts/', headers: TokenSingleton().authHeader).then((Response
    resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(utf8.decode(resp.bodyBytes));
      } else {
        throw Exception('No tienes permisos para acceder a este recurso ${resp.statusCode}');
      }
    });
    return response.map((d) => Podcast.fromJSONListed(d)).toList();
  }

  static Future<List<Podcast>> getAllPodcasts() async {
    List<dynamic> response =
    await _client.get('$_url/podcasts/', headers: TokenSingleton().authHeader).then((Response resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(utf8.decode(resp.bodyBytes));
      } else {
        throw Exception('No tienes permisos para acceder a este recurso');
      }
    });
    return response.map((d) => Podcast.fromJSONListed(d)).toList();
  }

  static Future<List<Podcast>> getPopular() async {
    List<dynamic> response =
    await _client.get('$_url/trending-podcast/', headers: TokenSingleton().authHeader).then(
            (Response resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(utf8.decode(resp.bodyBytes));
      } else {
        throw Exception('No tienes permisos para acceder a este recurso' + resp.statusCode.toString());
      }
    });
    return response.map((d) => Podcast.popularJSON(d)).toList();
  }

  static Future<Podcast> getFromUrl(String Url) async {
    print(Url);
    dynamic response =
    await _client.get(Url, headers: TokenSingleton().authHeader).then((Response resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(utf8.decode(resp.bodyBytes));
      } else {
        throw Exception('No tienes permisos para acceder a este recurso ${resp.statusCode}');
      }
    });
    return Podcast.fromJSONDetailed(response);
  }

  static Future<Podcast> getTrending(String id) async {
    print('getting trending podcast info');
    dynamic response =
    await _client.get('$_url/podcast/$id', headers: TokenSingleton().authHeader).then((Response
    resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(utf8.decode(resp.bodyBytes));
      } else {
        throw Exception('No tienes permisos para acceder a este recurso ${resp.statusCode}');
      }
    });
    return Podcast.fromTrending(response);
  }

 /* static Future<List<Podcast>> searchPod(String query) async {
    Response resp = await _client.get('$_url/podcasts/?search=$query');
    if(resp.statusCode == 200) {
      // Ha ido bien, devolvemos las listas
      List<dynamic> lista = jsonDecode(utf8.decode(resp.bodyBytes));
      List<Podcast> songs = lista.map((dynamic d) => (Podcast.fromJSON(d) as Podcast )).toList();
      return songs;
    }else{
      throw Exception('La busqueda de Podcast ha ido mal. Codigo de error ${resp.statusCode}');
    }
  }*/

  static Future<List<Podcast>> searchPod(int limit, int offset, String query) async {
    print('searching podChaps $query');
    Response resp = await _client.get('$_url/podcasts/?search=$query&limit=$limit&offset=offset'
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
      else return lista.map((dynamic d) => Podcast.fromJSON(d)).toList();
    }
    else {
      throw Exception('La busqueda de Artist ha ido mal. Codigo de error ${resp.statusCode}');
    }
  }

}