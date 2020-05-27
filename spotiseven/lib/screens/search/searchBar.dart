import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/playlistDAO.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/screens/search/searchWrapper.dart';
import 'package:spotiseven/usefullMethods.dart';


class SearchBarScreen extends StatefulWidget {
  @override
  _SearchBarScreenState createState() => _SearchBarScreenState();
}


class _SearchBarScreenState extends State<SearchBarScreen> {
  List<Playlist> playlists = List();

  final SearchBarController<String> _searchCtrl = SearchBarController();


  Future<List<String>> search(String search) async {
    await Future.delayed(Duration(seconds: 1));
    print("search started");
    playlists = await PlaylistDAO.searchPlaylist(8,0, search);

    print("awaits ok");

    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchWrapper(
      pls: playlists,
      word: search,
    )));
    return [''];
  }


  _loader(){
    return Center(
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Center(
                    child: Text(
                        'Loading...',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  _cancelButton(){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          'CANCEL',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: Colors.white
          ),
        )
      ),
    );
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
              flex: 4,
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
                hintText: 'Write hear your search',
                hintStyle: TextStyle(color: Colors.white70),
                debounceDuration: Duration(seconds: 2),
                minimumChars: 2,
                searchBarPadding: EdgeInsets.fromLTRB(30, 90, 30, 0),
                searchBarController: _searchCtrl,
                cancellationWidget: _cancelButton(),
                textStyle: TextStyle(
                  color: Colors.white
                ),
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
//                loader: _loader(),
                onItemFound: (String s, int index) {
                  return Text('');
                },
                searchBarStyle: SearchBarStyle(
                  backgroundColor: Colors.black,
                ),
              ),
            ),
            Expanded(
              flex: 4,
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
