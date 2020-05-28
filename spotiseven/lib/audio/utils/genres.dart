import 'package:spotiseven/audio/utils/podcast.dart';

class Genres {
  String url;
  String name;
  List<Podcast> podcasts;

  Genres({
    this.url,
    this.name,
  }) {
    this.podcasts = List();
  }

  static Genres fromJSON(Map<String, Object> json) {
    Genres g = Genres(url: json['url'], name: json['name']);
    g.podcasts = (json['podcasts'] as List).map((j) => Podcast.fromGenre(j)).toList();
    return g;
  }

}
