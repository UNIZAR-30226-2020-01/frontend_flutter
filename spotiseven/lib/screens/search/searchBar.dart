import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/DAO/albumDAO.dart';
import 'package:spotiseven/audio/utils/DAO/artistDAO.dart';
import 'package:spotiseven/audio/utils/DAO/playlistDAO.dart';
import 'package:spotiseven/audio/utils/DAO/songDAO.dart';
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/audio/utils/artist.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/usefullMethods.dart';

class SearchBarScreen extends StatefulWidget {
  @override
  _SearchBarScreenState createState() => _SearchBarScreenState();
}


class _SearchBarScreenState extends State<SearchBarScreen> {
  List<Playlist> playlists = List();
  List<Song> songs = List();
  List<Artist> artists = List();
  List<Album> albums = List();

  final SearchBarController<String> _searchCtrl = SearchBarController();


  Future<List<String>> search(String search) async {
    await Future.delayed(Duration(seconds: 1));
    print("search starteed");
    playlists = await PlaylistDAO.searchPlaylist(search);
    artists = await ArtistDAO.searchArtist(search);
    songs = await SongDAO.searchSong(search);
    albums = await AlbumDAO.searchAlbum(search);
    //todo: meter los podcast bro

    print("awaits ok");
    print("playlists number: " + playlists.length.toString());
    print("artists number: " + artists.length.toString());
    print("songs number: " +  songs.length.toString());
    print("albums number: " +  albums.length.toString());
    /*return List.generate(playlists.length, (int index) {
      return playlists;
    }
    );*/
    List<String> devol = List();
    devol.add("PLAYLISTS: ");
    for (int i=0; i<playlists.length; i++){
      devol.add(playlists[i].title);
    }
    devol.add(" ");
    devol.add("SONGS:");
    for (int i=0; i<songs.length; i++){
      devol.add(songs[i].title);
    }
    devol.add(" ");
    devol.add("ARTISTS:");
    for (int i=0; i<artists.length; i++){
      devol.add(artists[i].name);
    }
    devol.add(" ");
    devol.add("ALBUMS:");
    for (int i=0; i<albums.length; i++){
      devol.add(albums[i].titulo);
    }
    return devol;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.fromLTRB(90, 140, 90, 0),
                color: Colors.white,
                child: UsefulMethods.text('SEARCH', 15.0, 5.0, 0, 0, 0, 1.0),
              ),
            ),
            Expanded(
              flex: 5,
              child: SearchBar<String>(
                onSearch: search,
                searchBarPadding: EdgeInsets.fromLTRB(30, 90, 30, 0),
                searchBarController: _searchCtrl,
                cancellationText: Text("Cancelar"),
                textStyle: TextStyle(
                  color: Colors.white
                ),
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                loader: Center(child: Text('loading....')),
                onItemFound: (String s, int index) {
                  return Text(s);
                },
                searchBarStyle: SearchBarStyle(
                  backgroundColor: Colors.black,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/recomendations');
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/logo.png')),
                  ),
                  /*height: 400,
                  color: Colors.pink,*/
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
