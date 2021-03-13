import 'package:flutter/material.dart';
import 'services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TutorCard extends StatefulWidget {
  final Widget child;

  TutorCard({Key key, @required this.child}) : super(key: key);

  @override
  _TutorCardState createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  crudMethods crudObj = new crudMethods();
  QuerySnapshot tutors;

  @override
  // ignore: must_call_super
  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        tutors = results;
      });
    });
  }

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
                  infodis(),
                  // widget.child,
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

  Widget infodis() {
    if (tutors != null) {
      return ListView.builder(
        itemCount: tutors.docs.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(tutors.docs[i].data()['t_fname']),
            subtitle: Text(tutors.docs[i].data()['t_lname']),
          );
        },
      );
    } else {
      return Text('Loading.. Please wait..');
    }
  }
}
