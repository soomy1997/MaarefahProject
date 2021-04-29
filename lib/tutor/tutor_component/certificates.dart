import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:flutter/material.dart';


class Certificates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          'Certificates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff14213C),
        leading: GestureDetector(
          onTap: () {},
          child: Icon(Icons.arrow_back_ios_sharp),
        ),
      ),
      body: ListView(scrollDirection: Axis.vertical, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              elevation: 14.0,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent[400],
                                //border: Border.all(width:1.0),
                                borderRadius: BorderRadius.circular(11)),
                            height: 180,
                            width: 270,
                            child: new Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                new Text(
                                  'Tutoring Certification',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Text(
                                  'Lorem Ipsum',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 65,
                                    ),
                                    new Icon(
                                      Icons.file_download,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    new Text(
                                      'DOWNLOAD',
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              elevation: 14.0,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent[400],
                                //border: Border.all(width:1.0),
                                borderRadius: BorderRadius.circular(11)),
                            height: 180,
                            width: 270,
                            child: new Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                new Text(
                                  'Tutoring Certification',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Text(
                                  'Lorem Ipsum',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 65,
                                    ),
                                    new Icon(
                                      Icons.file_download,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    new Text(
                                      'DOWNLOAD',
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              elevation: 14.0,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent[400],
                                //border: Border.all(width:1.0),
                                borderRadius: BorderRadius.circular(11)),
                            height: 180,
                            width: 270,
                            child: new Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                new Text(
                                  'Tutoring Certification',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Text(
                                  'Lorem Ipsum',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 65,
                                    ),
                                    new Icon(
                                      Icons.file_download,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    new Text(
                                      'DOWNLOAD',
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              elevation: 14.0,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent[400],
                                //border: Border.all(width:1.0),
                                borderRadius: BorderRadius.circular(11)),
                            height: 180,
                            width: 270,
                            child: new Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                new Text(
                                  'Tutoring Certification',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Text(
                                  'Lorem Ipsum',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 65,
                                    ),
                                    new Icon(
                                      Icons.file_download,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    new Text(
                                      'DOWNLOAD',
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              elevation: 14.0,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent[400],
                                //border: Border.all(width:1.0),
                                borderRadius: BorderRadius.circular(11)),
                            height: 180,
                            width: 270,
                            child: new Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                new Text(
                                  'Tutoring Certification',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Text(
                                  'Lorem Ipsum',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 65,
                                    ),
                                    new Icon(
                                      Icons.file_download,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    new Text(
                                      'DOWNLOAD',
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              elevation: 14.0,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent[400],
                                //border: Border.all(width:1.0),
                                borderRadius: BorderRadius.circular(11)),
                            height: 180,
                            width: 270,
                            child: new Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                new Text(
                                  'Tutoring Certification',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Text(
                                  'Lorem Ipsum',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 65,
                                    ),
                                    new Icon(
                                      Icons.file_download,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    new Text(
                                      'DOWNLOAD',
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              elevation: 14.0,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent[400],
                                //border: Border.all(width:1.0),
                                borderRadius: BorderRadius.circular(11)),
                            height: 180,
                            width: 270,
                            child: new Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                new Text(
                                  'Tutoring Certification',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Text(
                                  'Lorem Ipsum',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 65,
                                    ),
                                    new Icon(
                                      Icons.file_download,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    new Text(
                                      'DOWNLOAD',
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}