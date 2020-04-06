import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/audio/utils/artist.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/song.dart';

class PlaylistDAO {
  // TODO: Quitar. Es para hacer pruebas
  static Album _pruebaAlbum1 = Album(
      titulo: 'El Rap',
      artista: Artist(name: 'Pedro No Tonto'),
      photoUrl:
          'https://yt3.ggpht.com/a/AATXAJzgtF2V2m4KsP1ZHU12UcqzoDBEL4GH4e_CmQ=s288-c-k-c0xffffffff-no-rj-mo');
  static Album _pruebaAlbum2 = Album(
      titulo: 'El Rock',
      artista: Artist(name: 'Pedro No Tonto'),
      photoUrl:
          'https://images-na.ssl-images-amazon.com/images/I/919JyJJiTtL._SL1500_.jpg');
  static Album _pruebaAlbum3 = Album(
      titulo: 'El Reggae',
      artista: Artist(name: 'Pedro No Tonto'),
      photoUrl:
          'https://images-na.ssl-images-amazon.com/images/I/81AEst8HUtL._SL1422_.jpg');
  static Album _pruebaAlbum4 = Album(
      titulo: 'El Pop?',
      artista: Artist(name: 'Pedro No Tonto'),
      photoUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQvQbsbqx_j5eyjnzdzHER7bO77o7XUedQ-Pv-JJLXkodOIrRmn');
  static Album _pruebaAlbum5 = Album(
      titulo: 'El Dubstep',
      artista: Artist(name: 'Pedro No Tonto'),
      photoUrl:
          'https://image.shutterstock.com/image-photo/serious-computer-hacker-dark-clothing-600w-1557297230.jpg');

  // TODO: Quitar. Es para hacer pruebas
  static Playlist _pruebaPlaylist = Playlist(
    playlist: [
      Song.fromJSON(jsonDecode(
          '{"title": "Rap chungo de Internet", "url": "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/no_curator/Yung_Kartz/August_2019/Yung_Kartz_-_04_-_One_Way.mp3"}'))
        ..album = _pruebaAlbum1,
      Song.fromJSON(jsonDecode(
          '{"title": "Rock chungo de Internet", "url": "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Ziklibrenbib/The_New_Monitors/st/The_New_Monitors_-_08_-_Hematoma.mp3"}'))
        ..album = _pruebaAlbum2,
      Song.fromJSON(jsonDecode(
          '{"title": "Reggae? de Internet", "url": "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/KBOO/collection_of_lo/Live_at_KBOO_for_Higher_Reasoning_Reggae_Time_10302016/collection_of_lo_-_05_-_CoLoSo-05Heartache-Oct_2016-LIVE.mp3"}'))
        ..album = _pruebaAlbum3,
      Song.fromJSON(jsonDecode(
          '{"title": "Pop? de Internet", "url": "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/Blue_Dot_Sessions/Banana_Cream/Blue_Dot_Sessions_-_Popism.mp3"}'))
        ..album = _pruebaAlbum4,
      Song.fromJSON(jsonDecode(
          '{"title": "Dubstep de Internet", "url": "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/blocSonic/DJ_Spooky/Of_Water_and_Ice/DJ_Spooky_-_11_-_Of_Water_and_Ice_feat_Jin-Xiang_JX_Yu_Dubstep_Remix_-_Bonus_Track.mp3"}'))
        ..album = _pruebaAlbum5,
    ],
    title: 'Prueba de playlist',
    user: 'Pedro El Listo',
    photoUrl:
        'https://m.media-amazon.com/images/M/MV5BYmQ0ZTY2Y2YtZWZmNy00M2EwLThhZDAtOTM3ZmIxZTQ5ZWY1XkEyXkFqcGdeQXVyNTU2NzcwMTQ@._V1_.jpg',
  );

  static var _listPlaylist = [
    _pruebaPlaylist,
    _pruebaPlaylist,
    _pruebaPlaylist,
    _pruebaPlaylist,
    _pruebaPlaylist,
    _pruebaPlaylist,
    _pruebaPlaylist,
    _pruebaPlaylist,
  ];
  // TODO: Fin de pruebas

  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static Future<List<Playlist>> getAllPlaylists() async {
//    return Future.delayed(Duration(seconds: 3), () => _listPlaylist);
    Response response = await _client.get('$_url/playlists');
    // Convertimos los json a playlist
    // TODO: Comprobar el campo de las playlist
    return (jsonDecode(response.body) as List<dynamic>)
        .map((d) => Playlist.fromJSON(d))
        .toList();
  }
}