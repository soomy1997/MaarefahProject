import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_1/utils/constants.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController name;

  TextEditingController email;

  String nameValue;

  String emailValue;

  String messageValue;

  final formKey = GlobalKey<FormState>();

  var _selectedIndex = 3;
  onItemPressed(index) {
    if (index != _selectedIndex) {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'Contact Us!',
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Image(
                        image: AssetImage("images/pic2.png"),
                        height: MediaQuery.of(context).size.height * 0.24,
                        width: MediaQuery.of(context).size.width * 0.99,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: boxShadow(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Contact Us",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        nameEntryField(),
                                        emailEntryField(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Message",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        messageEntryField(),
                                      ],
                                    ))
                              ],
                            ),
                            Positioned(
                              top: 370,
                              left: 110,
                              right: 110,
                              bottom: 0,
                              child: floatingButton(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
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
    return BoxDecoration(color: Colors.grey[200], boxShadow: []);
  }

  void _send() {
    if (formKey.currentState.validate()) {}
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
