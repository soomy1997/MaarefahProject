import 'dart:ui';
import 'package:flutter/material.dart';

class SignOutCustomDialogBox extends StatefulWidget {
  final String title, descriptions, text, text2;
  final Image img;

  const SignOutCustomDialogBox(
      {Key key, this.title, this.descriptions, this.text, this.img, this.text2})
      : super(key: key);

  @override
  _SignOutCustomDialogBoxState createState() => _SignOutCustomDialogBoxState();
}

class _SignOutCustomDialogBoxState extends State<SignOutCustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: padding,
              top: avatarRadius + padding,
              right: padding,
              bottom: padding),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Container(
            height: 130,
            width: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.descriptions,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xffF9A21B),
                        child: MaterialButton(
                          minWidth: 150,
                          //padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(widget.text,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey,
                        child: MaterialButton(
                          minWidth: 150,
                          // padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(widget.text2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static const double padding = 20;
  static const double avatarRadius = 20;
}
