import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/user/tokenSingleton.dart';
import 'package:spotiseven/user/user.dart';


class UserDAO {

  static String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';
  static Client _client = Client();

  ///
  /// Dado un User [user] que contiene el nombre de usuario con el que
  /// se va a iniciar sesion, la llamada al método devuelve el usuario
  /// con los campos rellenados y el token de autentificacion.
  ///
  static Future<bool> authUserWithPassword(User user, String password) async {
    // Obtenemos el token con los datos facilitados
    bool ok = await TokenSingleton().getTokenFromRemote(user.username, password);
    print('OK: $ok');
    // Comprobamos la validez del token
    return ok && ((await getUserData()) != null);
  }

  static Future<bool> registerUserWithPassword(User user, String password) async {
    Response response = await _client.post('$_url/register/', body: {
      'username': user.username,
      'password': password,
    });
    print('$_url/register/');
    if(response.statusCode == 201){
      // Ha ido bien
      return true;
    }else{
      // Ha habido problemas
      throw Exception('Problema en el registro. Codigo de error ${response.statusCode}');
    }
  }

  static Future<User> getUserData() async{
    TokenSingleton tokenSingleton = TokenSingleton();
    Response response = await _client.get('$_url/current-user/', headers: tokenSingleton.authHeader);
    if(response.statusCode == 200){
//      print('GETUSERDATA: ${response.body}');
      // TODO: Cuidado que esto esta devolviendo una lista.
      return User.fromJSON((jsonDecode(response.body) as List)[0]);
    }else{
      print('RESPONSE EN ELSE de getUserData: ${response.body}');
      return null;
    }
  }

  static Future<void> logOut() async {
    TokenSingleton tokenSingleton = TokenSingleton();
    await tokenSingleton.deleteFromSecure();
  }
  
  // Sincronización de la reproducción con el backend
  static Future<void> saveSongState(Song song, Duration timestamp) async {
    Response resp = await _client.get('${song.urlApi}set_playing?t=${timestamp.inSeconds}');
    if(resp.statusCode == 200){
      // Ha ido bien -> Devuelve una cadena que dice el status
      print('${utf8.decode(resp.bodyBytes)}');
    }else{
      throw Exception('Error al guardar la song ${song.title} en el remoto. Codigo de error ${resp.statusCode}');
    }
  }

  static Future<Map<String, Object>> retrieveSongWithTimestamp() async {
    Response resp = await _client.get('$_url/current-user/');
    if(resp.statusCode == 200){
      // En playing   -> song en forma de detalle (DINAMICO. Puede ser un podcast chapter)
      // En timestamp -> entero en segundos
      dynamic map = jsonDecode(utf8.decode(resp.bodyBytes));
      if(map['playing'] != null && map['timestamp'] != null){
        // Ha ido bien
        return {
          'playing': Song.fromJsonDetail(map['playing']),
          'timestamp': Duration(seconds: int.parse(map['timestamp'] as String)),
        };
      }else{
        // No se ha enccontrado el objeto necesario en el remoto. No se reproducia nada
        return null;
      }
    }else{
      throw Exception('Error al obtener la cancion del remoto. Codigo de error ${resp.statusCode}');
    }
  }

  // Follow User
  static Future<void> followUser(User user) async {
    Response resp = await _client.get('${user.url}follow/');
    if(resp.statusCode == 200){
      // Ha ido bien -> Le estamos siguiendo
    }else{
      throw Exception('Error al seguir al usuario ${user.username}. Codigo de error ${resp.statusCode}');
    }
  }

  // Unfollow User
  static Future<void> unfollowUser(User user) async {
    Response resp = await _client.get('${user.url}unfollow/');
    if(resp.statusCode == 200){
      // Ha ido bien -> Le hemos dejado de seguir
    }else{
      throw Exception('Error al dejar de seguir al usuario ${user.username}. Codigo de error ${resp.statusCode}');
    }
  }
}