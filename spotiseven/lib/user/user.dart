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
    return User(
        url: json['url'],
        username: json['username']
    );
  }
  static User imageJSON(Map<String, Object> json) {
    return User(
        url: json['url'],
        imageUrl: json['icon']
    );
  }
}
