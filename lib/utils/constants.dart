import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
  MinLengthValidator(100, errorText: 'Must be at least 100 characters.'),
]);
