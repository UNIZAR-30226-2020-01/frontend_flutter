import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayingScreen extends StatefulWidget {
  @override
  _PlayingScreenState createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'SONG TITLE',
          style: TextStyle(
            // TODO: Poner la fuentes
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Card(
        // TODO: Poner aqui el color
        color: Colors.green[500],
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () => print('share'),
                  icon: Icon(Icons.share),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://yt3.ggpht.com/a/AATXAJzgtF2V2m4KsP1ZHU12UcqzoDBEL4GH4e_CmQ=s288-c-k-c0xffffffff-no-rj-mo'),
              radius: 70,
            ),
            Text(
              'The Song Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Artist Name',
            ),
            // Controles de musica
            buildAudioControlls(),
            buildPlaylistControlls(),
          ],
        ),
      ),
    );
  }

  ButtonBar buildPlaylistControlls() {
    return ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () => print('subtitles'),
                icon: Icon(Icons.subtitles),
              ),
              IconButton(
                onPressed: () => print('playlist_add'),
                icon: Icon(Icons.playlist_add),
              ),
            ],
          );
  }

  ButtonBar buildAudioControlls() {
    return ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(onPressed: () => print('Repeat'), icon: Icon(Icons.repeat_one), ),
              IconButton(onPressed: () => print('skip_previous'), icon: Icon(Icons.skip_previous), ),
              IconButton(onPressed: () => print('play_arrow'), icon: Icon(Icons.play_arrow), ),
              IconButton(onPressed: () => print('skip_next'), icon: Icon(Icons.skip_next), ),
              IconButton(onPressed: () => print('volume_up'), icon: Icon(Icons.volume_up), ),
            ],
          );
  }
}
