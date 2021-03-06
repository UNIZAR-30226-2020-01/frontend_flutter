import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:dio/dio.dart' as dio;

import 'package:spotiseven/audio/utils/playlist.dart';
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
      //  Cuidado que esto esta devolviendo una lista.
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
    print('Guardando song ${song.title} -- ${timestamp.inSeconds} s');
    Response resp = await _client.get('${song.urlApi}set_playing?t=${timestamp.inSeconds}', headers: TokenSingleton().authHeader);
    if(resp.statusCode == 200){
      // Ha ido bien -> Devuelve una cadena que dice el status
      print('${utf8.decode(resp.bodyBytes)}');
    }else{
      throw Exception('Error al guardar la song ${song.title} en el remoto. Codigo de error ${resp.statusCode}');
    }
  }

  static Future<Map<String, Object>> retrieveSongWithTimestamp() async {
    Response resp = await _client.get('$_url/current-user/', headers: TokenSingleton().authHeader);
    if(resp.statusCode == 200){
      // En playing   -> song en forma de detalle (DINAMICO. Puede ser un podcast chapter)
      // En timestamp -> entero en segundos
      // Cuidado que esto devuelve una lista
      dynamic map = (jsonDecode(utf8.decode(resp.bodyBytes)) as List)[0];
      if(map['playing'] != null && map['timestamp'] != null){
        // Ha ido bien
        return {
          'playing': Song.fromJsonDetail(map['playing']),
          'timestamp': Duration(seconds: map['timestamp']),
        };
      }else{
        // No se ha enccontrado el objeto necesario en el remoto. No se reproducia nada
        return null;
      }
    }else{
      throw Exception('Error al obtener la cancion del remoto. Codigo de error ${resp.statusCode}');
    }
  }

  static Future<List<User>> following(User user) async {
    Response resp = await _client.get('$_url/current-user/', headers: TokenSingleton()
        .authHeader);
    if(resp.statusCode == 200){
      print('RESPONE: ${resp.body}');
      Map<String, dynamic> map = (jsonDecode(utf8.decode(resp.bodyBytes)) as List)[0];
      List<dynamic> lista = map['following'];
      return lista.map((dynamic d) => User.fromJSON(d)).toList();
//      return lista['following'].map((dynamic d) => User.fromJSON(d)).toList();
    }
    else{
      throw Exception('Error al coger los followed de ${user.username}. Codigo de error ${resp
          .statusCode}');
    }
  }

  static Future<List<User>> followers(User user) async {
    Response resp = await _client.get('$_url/current-user/', headers: TokenSingleton()
        .authHeader);
    if(resp.statusCode == 200){
      print('RESPONE: ${resp.body}');
      Map<String, dynamic> map = (jsonDecode(utf8.decode(resp.bodyBytes)) as List)[0];
      List<dynamic> lista = map['followers'];
      return lista.map((dynamic d) => User.fromJSON(d)).toList();
    }
    else{
      throw Exception('Error al coger los followers de ${user.username}. Codigo de error ${resp
          .statusCode}');
    }
  }

  static Future<bool> amIFollowing(User user) async {
    Response resp = await _client.get('$_url/current-user/', headers: TokenSingleton()
        .authHeader);
    if(resp.statusCode == 200){
      print('RESPONE: ${resp.body}');
      Map<String, dynamic> map = (jsonDecode(utf8.decode(resp.bodyBytes)) as List)[0];
      List<dynamic> lista = map['following'];
      if (lista.contains(user))
        return true;
      else
        return false;
    }
    else{
      throw Exception('Error al coger los followers de ${user.username}. Codigo de error ${resp
          .statusCode}');
    }
  }



  // Follow User
  static Future<void> followUser(User user) async {
    print('following ${user.url}follow/');
    Response resp = await _client.get('${user.url}follow/', headers: TokenSingleton().authHeader);
    if(resp.statusCode == 200){
      // Ha ido bien -> Le estamos siguiendo
      print('user ${user.username} followd');
    }else{
      throw Exception('Error al seguir al usuario ${user.username}. Codigo de error ${resp.statusCode}');
    }
  }

  // Unfollow User
  static Future<void> unfollowUser(User user) async {
    print('unfollowing ${user.url}unfollow');
    Response resp = await _client.get('${user.url}unfollow/', headers: TokenSingleton()
        .authHeader);
    if(resp.statusCode == 200){
      // Ha ido bien -> Le hemos dejado de seguir
      print('user ${user.username} unfollowd');
    }else{
      throw Exception('Error al dejar de seguir al usuario ${user.username}. Codigo de error ${resp.statusCode}');
    }
  }

  // Playlist de los usuarios que sigues
  static Future<List<Playlist>> followingPlaylists(int limit, int offset) async {
    print('ilimit: $limit & offset: $offset');
    Response response = await _client.get('$_url/user/followed/playlists/?limit=$limit&offset=$offset',
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
      else return lista.map((dynamic d) => Playlist.fromJSONListed(d)).toList();
    }
    else {
      throw Exception(
          'Error al obtener las playlist de los siguiendo. Codigo de error ${response.statusCode}'
      );
    }
  }


  /// Busca el parámetro en: nombre del usuario y en sus playlists
  static Future<List<User>> searchUser(String query) async {
    Response resp = await _client.get('$_url/s7_user/?search=$query');
    if (resp.statusCode == 200) {
      // Ha ido bien, devolvemos las listas
      List<dynamic> lista = jsonDecode(utf8.decode(resp.bodyBytes));
      List<User> users =  lista.map((dynamic d) => User.fromJSON(d) ).toList();
      return users;
    } else {
      throw Exception(
          'La busqueda de Song ha ido mal. Codigo de error ${resp.statusCode}');
    }
  }

  static Future<String> userImg(String url) async {
    Response resp = await _client.get(url);
    if (resp.statusCode == 200) {
      // Ha ido bien, devolvemos las listas
      dynamic d = jsonDecode(utf8.decode(resp.bodyBytes));
      return User.img(d);
    } else {
      throw Exception(
          'La busqueda de user con img ha ido mal. Codigo de error ${resp.statusCode}');
    }
  }


  static Future<User> putImage(File image) async {

    print('${image.path}');

    var file = await dio.MultipartFile.fromFile(image.path);

    print('${file.toString()}');

    dio.FormData fd = dio.FormData.fromMap({
      'icon': file,
    });

    print('$_url/update-user/');
    print('FormData = ${fd.files}');

    dio.Response response = await dio.Dio().put('$_url/update-user/',
        data: fd, options: dio.Options(headers: TokenSingleton().authHeader));

    if (response.statusCode == 200) {
      // Ha ido bien
      print('El update de foto ha ido bien');
      print('Respuesta ==> ${response.data}');
      print('${response.data.runtimeType}');
      return User.userJSON(response.data);
    } else {
      print('${response.data}');
      throw Exception(
          'Error al subir un user. Codigo de error: ${response.statusCode}');
    }
  }

  static Future<User> putName(String newName) async {
    Response response = await _client.get('$_url/update-user/?name=$newName',
        headers: TokenSingleton().authHeader);

    if (response.statusCode == 200) {
      // Ha ido bien
      print('El update de foto ha ido bien');
      print('Respuesta ==> ${response.body}');
      print('${response.body.runtimeType}');
      dynamic d = jsonDecode(utf8.decode(response.bodyBytes));
      return User.userJSON(d);
    } else {
      print('${response.body}');
      throw Exception(
          'Error al subir un username. Codigo de error: ${response.statusCode}');
    }
  }

}
