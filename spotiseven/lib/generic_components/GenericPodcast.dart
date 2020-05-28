import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/PodcastChapterWrapper.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/DAO/podcastDAO.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/generic_components/GenericHorizontalWidget.dart';
import 'package:spotiseven/generic_components/GenericNewPodChapter.dart';
import 'package:spotiseven/screens/podcast/podcast_chapter_info.dart';

//MUESTRA EL PODCAST Y SUS CAPITULOS
class GenericPodcast extends StatefulWidget {
  final Podcast podcast;

  GenericPodcast({this.podcast});

  @override
  _GenericPodcastState createState() => _GenericPodcastState();
}

class _GenericPodcastState extends State<GenericPodcast> {
  static const String sub = 'SUBSCRIBE';
  static const String unsub = 'UNSUBSCRIBE';
  String estadoPod = "LOADING...";
  Podcast get podcast => widget.podcast;
  bool sigue = false;

  ScrollController _scrollController;

  @override
  void initState() {
    estado();
    print("Podcast: " + widget.podcast.title);
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    super.initState();
  }

  Future<void> estado() async {
    PodcastDAO.amISusbscribed(podcast).then(
          (bool x) {
        setState(() {
          sigue = x;
          if (sigue)
            estadoPod = unsub;
          else
            estadoPod = sub;
        });
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _text(context, id, size, r, g, b, op) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        id,
        textAlign: TextAlign.end,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          fontSize: size,
          letterSpacing: 8,
          wordSpacing: 2,
          color: Color.fromRGBO(r, g, b, op),
        ),
      ),
    );
  }

  _image(context, url) {
    return Image(
      fit: BoxFit.cover,
      alignment: Alignment.center,
      image: NetworkImage(url),
    );
  }

  _border() {
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.white,
    );
  }

  _borderBlack() {
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.black,
    );
  }

  _imageContainer() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: _image(context, widget.podcast.photoUrl),
      ),
    );
  }

  _textContainer() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: _border(),
      //color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: AutoSizeText(
                  widget.podcast.title,
                  maxLines: 2,
//                maxFontSize: 300,
                  minFontSize: 19,
                  wrapWords: true,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 8,
                    wordSpacing: 2,
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.001,
                child: IconButton(
                  onPressed: () {
                    print('presionado boton info de podcast');
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistInfo(podcast: widget.podcast)));
                  },
                  icon: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
//            width: MediaQuery.of(context).size.width*0.25,
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: _text(context, '${widget.podcast.canal.title}', 40.0, 0, 0, 0, 1.0),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
//            width: MediaQuery.of(context).size.width*0.25,
            child: _text(context, '${widget.podcast.numChapters} chapters', 10.0, 0, 0, 0, 1.0),
          ),
        ],
      ),
    );
  }

  _botonFollow() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.width * 0.2,
        child: FlatButton(
            child: Container(
              height: 30,
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              decoration: _borderBlack(),
              child: _text(context, estadoPod, 40.0, 255, 255, 255, 1.0),
            ),
            onPressed: () async {
              print('Sigue: $sigue');
              PodcastDAO.subscribePod(podcast, sigue).then(
                (bool x) {
                  setState(() {
                    sigue = x;
                    if (sigue)
                      estadoPod = unsub;
                    else
                      estadoPod = sub;
                  });
                },
              );
            }));
  }

  _appBar(context) {
    return SliverAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Propiedades sliverappbar
        floating: true,
        snap: true,
        pinned: true,
        // Efectos
        leading: SizedBox(),
        stretch: true,
        onStretchTrigger: () => Future.delayed(Duration(microseconds: 2), () async {
              PodcastDAO.amISusbscribed(podcast).then(
                    (bool x) {
                  setState(() {
                    sigue = x;
                    if (sigue)
                      estadoPod = unsub;
                    else
                      estadoPod = sub;
                  });
                },
              );
              print('stretch');
            }),
        expandedHeight: 300,
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: [
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
            StretchMode.fadeTitle,
          ],
          background: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _imageContainer(),
                    _textContainer(),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: _text(context, 'CHAPTERS', 15.0, 0, 0, 0, 1.0),
                      ),
                      _botonFollow(),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  indent: 20,
                  endIndent: 20,
                  thickness: 4.0,
                ),
              ],
            ),
          ),
        ));
  }

  _alert(context) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(milliseconds: 1500), () {
            Navigator.of(context).pop(true);
          });
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              title: Center(
                child: Text(
                  'Playing...',
                  style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var pod = widget.podcast;
    print(pod.chapters[0].title);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: RefreshIndicator(
              onRefresh: () => Future.delayed(Duration(microseconds: 1), () => print('recargando')),
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  _appBar(context),
                  SliverList(
                    delegate: SliverChildListDelegate(widget.podcast.chapters
                        .map((el) => GenericHorizontalWidget(
                              args: [el.title, pod.canal.title, ''],
                              imageUrl: pod.photoUrl,
                              onPressedFunction: () {
                                _alert(context);
                                var playingSingleton = PlayingSingleton();
                                playingSingleton.setPlayList(PodcastChapterWrapper(el));
                                print('Reproduciendo ${playingSingleton.song.title}');
                                print('Pulsado en un new chapter');
                              },
                            ))
                        .toList()),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
