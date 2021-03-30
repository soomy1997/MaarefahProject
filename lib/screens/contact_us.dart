import 'dart:convert';
import 'dart:math';
import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String nameValue;

  String emailValue;

  String messageValue;

  final formKey = GlobalKey<FormState>();

  void _send() {}
  @override
  Widget build(BuildContext context) {
    final requistButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        highlightColor: Color(0xffB36D05),
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Send",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'Contact Us!',
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(36),
              child: Column(
                children: [
                  Column(
                    children: [
                      Image(
                        image: AssetImage("images/pic2.png"),
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: false,
                    style: h5,
                    validator: nameValidation,
                    decoration: textInputDecoratuon.copyWith(
                      hintText: 'Your Name',
                      prefixIcon: Icon(Icons.person),
                      labelText: "Name",
                      labelStyle: style.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    obscureText: false,
                    style: h5,
                    validator: nameValidation,
                    decoration: textInputDecoratuon.copyWith(
                      hintText: 'example@gmail.com',
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      labelStyle: style.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    height: 20.0,
                    width: double.infinity,
                    child:
                        Text("Message", textAlign: TextAlign.left, style: h4),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    maxLines: 9,
                    style: h5,
                    validator: textAreaValidation,
                    decoration: textInputDecoratuon.copyWith(
                        hintText: "Enter your message here"),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 35.0),
                  requistButon,
                  SizedBox(
                    height: 35.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  nameEntryField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextFormField(
        initialValue: nameValue,
        onSaved: (input) => nameValue = input,
        validator: (input) {
          if (input.isEmpty) {
            return "This field is required";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Name",
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }

  emailEntryField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextFormField(
        initialValue: emailValue,
        onSaved: (input) => emailValue = input,
        validator: (input) {
          if (input.isEmpty) {
            return "This field is required";
          }
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(input);
          if (!emailValid) {
            return "Please enter your email address in\nformat: yourname@example.com";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Email",
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }

  messageEntryField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextFormField(
        initialValue: messageValue,
        maxLines: 4,
        maxLength: 30,
        inputFormatters: [
          _Utf8LengthLimitingTextInputFormatter(30),
        ],
        onSaved: (input) => messageValue = input,
        validator: (input) {
          if (input.isEmpty) {
            return "This field is required";
          }

          return null;
        },
        decoration: InputDecoration(
          alignLabelWithHint: true,
          hintText: "Message",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }

  floatingButton() {
    return FloatingActionButton(
      onPressed: _send,
      child: Icon(
        Icons.send,
        color: Colors.white,
      ),
      backgroundColor: Colors.orange,
    );
  }

  boxShadow() {
    return BoxDecoration(color: Colors.grey[300], boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        blurRadius: 6, // soften the shadow
        spreadRadius: 3, //end the shadow
        offset: Offset(
          6.0, // Move to right 10  horizontally
          2.0, // Move to bottom 10 Vertically
        ),
      ),
      BoxShadow(
        color: Color.fromRGBO(255, 255, 255, 0.5),
        blurRadius: 6, // soften the shadow
        spreadRadius: 3, //end the shadow
        offset: Offset(
          -6.0, // Move to right 10  horizontally
          -2.0, // Move to bottom 10 Vertically
        ),
      ),
    ]);
  }
}

class _Utf8LengthLimitingTextInputFormatter extends TextInputFormatter {
  _Utf8LengthLimitingTextInputFormatter(this.maxLength)
      : assert(maxLength == null || maxLength == -1 || maxLength > 0);

  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength != null &&
        maxLength > 0 &&
        bytesLength(newValue.text) > maxLength) {
      // If already at the maximum and tried to enter even more, keep the old value.
      if (bytesLength(oldValue.text) == maxLength) {
        return oldValue;
      }
      return truncate(newValue, maxLength);
    }
    return newValue;
  }

  static TextEditingValue truncate(TextEditingValue value, int maxLength) {
    var newValue = '';
    if (bytesLength(value.text) > maxLength) {
      var length = 0;

      value.text.characters.takeWhile((char) {
        var nbBytes = bytesLength(char);
        if (length + nbBytes <= maxLength) {
          newValue += char;
          length += nbBytes;
          return true;
        }
        return false;
      });
    }
    return TextEditingValue(
      text: newValue,
      selection: value.selection.copyWith(
        baseOffset: min(value.selection.start, newValue.length),
        extentOffset: min(value.selection.end, newValue.length),
      ),
      composing: TextRange.empty,
    );
  }

  static int bytesLength(String value) {
    return utf8.encode(value).length;
  }
}
