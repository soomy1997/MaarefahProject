import 'package:flutter/material.dart';

class TutorCard extends StatefulWidget {
  final Widget child;

  TutorCard({Key key, @required this.child}) : super(key: key);

  @override
  _TutorCardState createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
