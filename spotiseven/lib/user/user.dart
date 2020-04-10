import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {

  // URL del recurso
  String url;

  // Username
  String username;

  User({this.url, this.username});

  static User fromJSON(Map<String, Object> json) {
    return User(
      url: json['url'],
      username: json['username']
    );
  }

}