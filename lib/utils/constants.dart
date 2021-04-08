import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

//inputs decorations (for text input feilds)
const textInputDecoratuon = InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder());

///////////////////////text styles////////////////////////////////

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
const whiteButtonsTextStyle = TextStyle(
  color: accentYellow,
  fontWeight: FontWeight.bold,
  fontSize: 17,
);

const greyButtonsTextStyle = TextStyle(
  color: kTextLightColor,
  fontWeight: FontWeight.bold,
  fontSize: 17,
);

//////////////////////////validations///////////////////////////
final nameValidation = MultiValidator([
  RequiredValidator(errorText: 'This field is required.'),
  MinLengthValidator(7, errorText: 'Full name must be at least 7 characters.')
]);

final passwordValidation = MultiValidator([
  RequiredValidator(errorText: 'This field is required.'),
  MinLengthValidator(7, errorText: 'Password must be at least 7 characters.'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

final emailValidation = MultiValidator([
  RequiredValidator(errorText: 'This field is required.'),
  EmailValidator(
      errorText:
          'Please enter your email address in format:\nyourname@example.com')
]);

final phoneValidaton = MultiValidator([
  RequiredValidator(errorText: 'This field is required.'),
  MinLengthValidator(10, errorText: 'Must be at least 10 digits.'),
  PatternValidator(
      r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$',
      errorText: 'Wrong phone format')
]);

final textAreaValidation = MultiValidator([
  RequiredValidator(errorText: 'This field is required.'),
  MinLengthValidator(30, errorText: 'Must be at least 30 characters.'),
]);

final textAreaValidation2 = MultiValidator([
  RequiredValidator(errorText: 'This field is required.'),
  MinLengthValidator(10, errorText: 'Must be at least 10 characters.'),
]);

final textReviewValidation = MultiValidator([
  RequiredValidator(errorText: 'This field is required.'),
]);

//////////////////////////app theme////////////////////////////////

//boxShadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);

//colors:
const primaryBlack = const Color(0xff0B0B0B);
const secondaryDarkBlue = const Color(0xff14213C);
const secondaryLightBlue = const Color(0xff23365B);
const kTextLightColor = Color(0xFF747474);
const secondaryDarkGrey = const Color(0xffbcbcbc);
const secondaryLightGrey = const Color(0xffdfdfdf);
const accentYellow = const Color(0xffF9A21B);
const accentOrange = const Color(0xffF05824);
const whiteBG = Colors.white;

// title, back button and icon
AppBar myAppBar1(
  context, {
  String title,
  IconButton iconButton,
}) {
  return AppBar(
    backgroundColor: secondaryDarkBlue,
    title: Text(title,
        style: TextStyle(
          color: Colors.white,
        )),
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    actions: <Widget>[iconButton],
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        tooltip: 'return to previous screen',
        onPressed: () {
          Navigator.pop(context);
        }),
  );
}

// title and back button only
AppBar myAppBar2(
  context, {
  String title,
}) {
  return AppBar(
    backgroundColor: secondaryDarkBlue,
    title: Text(title,
        style: TextStyle(
          color: Colors.white,
        )),
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        tooltip: 'return to previous screen',
        onPressed: () {
          Navigator.pop(context);
        }),
  );
}

// title only and action Button
AppBar myAppBar3(
  context, {
  String title,
  IconButton iconButton,
}) {
  return AppBar(
    backgroundColor: secondaryDarkBlue,
    title: Text(title,
        style: TextStyle(
          color: Colors.white,
        )),
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    actions: <Widget>[iconButton],
  );
}

// title only
AppBar myAppBar4(
  context, {
  String title,
}) {
  return AppBar(
    backgroundColor: secondaryDarkBlue,
    title: Text(title,
        style: TextStyle(
          color: Colors.white,
        )),
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
  );
}
