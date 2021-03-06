class User {
  // URL del recurso
  String url;

  // Username
  String username;
  String imageUrl;


  User({this.url, this.username,  this.imageUrl});


  addImage(String u){
    imageUrl=u;
  }

  static User fromJSON(Map<String, Object> json) {
    print(json['icon']);
    return User(
        url: json['url'],
        username: json['username'],
//        imageUrl: json['icon']
    );
  }
  static User userJSON(Map<String, Object> json) {
    return User(
        url: json['url'],
        imageUrl: json['icon']
    );
  }

  static String img(Map<String, Object> json){
    return json['icon'];
  }
}
