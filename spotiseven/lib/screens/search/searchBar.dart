import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:spotiseven/usefullMethods.dart';

class SearchBarScreen extends StatefulWidget {
  @override
  _SearchBarScreenState createState() => _SearchBarScreenState();
}


class _SearchBarScreenState extends State<SearchBarScreen> {

  Future<List<Text>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Text(
        "Title : $search $index",
      );
    });
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
              child: SearchBar<Text>(
                onSearch: search,
                searchBarPadding: EdgeInsets.fromLTRB(30, 90, 30, 0),
                textStyle: TextStyle(
                  color: Colors.white
                ),
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                loader: Center(child: Text('loading....')),
                onItemFound: (Text t, int index) {
                  return Text(t.toString());
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
