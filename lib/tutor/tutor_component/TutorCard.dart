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
    return Column(mainAxisSize: MainAxisSize.max,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.all(40),
            color: Colors.white,
            child: Container(
              height: 230,
              width: 230,
              padding: EdgeInsets.all(20),
              //child: widget.child,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 40,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  widget.child,
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // decoration: BoxDecoration(
              //   color: Colors.white, boxShadow: [
              //   BoxShadow(color: Colors.black, offset: Offset(10.0, 10.0))
              // ]),
            ),
          )
        ]);
  }
}
