import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/playlistDAO.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/popUpSong.dart';

class GenericHoriSong extends StatefulWidget {
  final String imageUrl;
  Song s;

  final List<String> args;

  final Function onPressedFunction;

  GenericHoriSong({this.args, this.s, this.imageUrl, this.onPressedFunction});

  @override
  _GenericHoriSongState createState() => _GenericHoriSongState();
}

class _GenericHoriSongState extends State<GenericHoriSong> {
  Song get s => widget.s;
  List<Playlist> _playlist = List();

  @override
  void initState(){
    PlaylistDAO.getAllPlaylists().then((List<Playlist> playlist) {
      setState(() {
        _playlist = playlist;
      });
    });
    super.initState();
  }

  _image(context) {
    final String url = widget.args[2].toString();
    return Image(
      fit: BoxFit.cover,
      alignment: Alignment.center,
      image: NetworkImage(widget.imageUrl),
    );
  }

  _text(context, id) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        id.toUpperCase(),
        textAlign: TextAlign.end,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          letterSpacing: 5,
          fontSize: 100,
          wordSpacing: 2,
          color: Colors.white,
        ),
      ),
    );
  }

  _options(){
    return [
      IconButton(
        onPressed: () {
          setState(() {
            widget.s.setFavorite(!s.favorite);
          });
        },
        icon: Icon(
          s.favorite ? Icons.star : Icons.star_border,
          color: s.favorite ? Colors.yellow : Colors.white,
        ),
      ),
      PopUpSong(s: s, playlist: _playlist,),
    ];
  }

  _elementoEvento(context) {

    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.width * 0.2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: _image(context),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.7,
              color: Colors.black,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: _text(context, widget.args[0]),
                      ),
                      Expanded(
                        flex: 2,
                        child: Divider(
                          color: Colors.white,
                          thickness: 2.0,
                          endIndent: 80,
                          indent: 80,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child:_text(context, widget.args[1]),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        s.setFavorite(!s.favorite);
                      });
                    },
                    icon: Icon(
                      s.favorite ? Icons.star : Icons.star_border,
                      color: s.favorite ? Colors.yellow : Colors.white,
                    ),
                  ),
                  PopUpSong(s: s, playlist: _playlist,),

                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressedFunction,
      child: Container(
        alignment: Alignment.center,
        //tamaño del contenedor princiapl que contiene las filasc
        height: MediaQuery.of(context).size.height * 0.15,
        //width  : MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            _elementoEvento(context),
          ],
        ),
      ),
    );
  }
}
