import 'package:flutter/material.dart';

//inputs decorations (for text input feilds)
const textInputDecoratuon = InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder());

///////////////////////text styles////////////////////////////////

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);
const kTextLightColor = Color(0xFF747474);
const kSecondaryColor = Color(0xFFFFA41B);


const style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

//page headlines
const h1 =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28);

//black bold labels
const h4 =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17);

//grey thin texts
const h5 =
    TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 17);

//yellow buttons text
const yellowButtonsTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 17,
);
