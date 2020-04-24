import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
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
    // TODO: Change this URL
    Response response = await _client.get('$_url/current-user/', headers: tokenSingleton.authHeader);
    if(response.statusCode == 200){
//      print('GETUSERDATA: ${response.body}');
      // TODO: Cuidado que esto esta devolviendo una lista.
      return User.fromJSON((jsonDecode(response.body) as List)[0]);
    }else{
      print('RESPONSE EN ELSE: ${response.body}');
      return null;
    }
  }

  static Future<void> logOut() async {
    TokenSingleton tokenSingleton = TokenSingleton();
    await tokenSingleton.deleteFromSecure();
  }

}