import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenericHorizontalWidget extends StatelessWidget {
  final String imageUrl;

  final List<String> args;

  final Function onPressedFunction;



  GenericHorizontalWidget({this.args, this.imageUrl, this.onPressedFunction});

  _image(context) {
    final String url = args[2].toString();
    return Image(
      fit: BoxFit.cover,
      alignment: Alignment.center,
      image: NetworkImage(imageUrl),
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
          letterSpacing: 8,
          wordSpacing: 2,
          color: Colors.white,
        ),
      ),
    );
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
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _text(context, args[0]),
                  ),
                  Expanded(
                    flex: 1,
                    child: Divider(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      thickness: 2.0,
                      endIndent: 100,
                      indent: 100,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:_text(context, args[1]),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedFunction,
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
