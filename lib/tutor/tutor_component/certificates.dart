import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';

class Certificates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'Certificate',
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
                                  'this certificate',
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
                                    new TextButton.icon(
                                      onPressed: () async {
                                        // final status =
                                        //     await Permission.storage.request();

                                        // if (status.isGranted) {
                                        //   final externalDir =
                                        //      await getExternalStorageDirectory();

                                        //  final id =
                                        //       await FlutterDownloader.enqueue(
                                        //     url:
                                        //         "https://firebasestorage.googleapis.com/v0/b/ma-arefah-app.appspot.com/o/certificates%2FVolunteer-Certificate.pdf?alt=media&token=1a9a5108-6ddb-4b37-ad08-2e6a3471d40f",
                                        //     savedDir: externalDir.path,
                                        //     fileName: "download",
                                        //     showNotification: true,
                                        //     openFileFromNotification: true,
                                        //   );
                                        // } else {
                                        //   print("Permission deined");
                                        // }
                                      },
                                      label: Text(
                                        'DOWNLOAD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.file_download,
                                        color: Colors.white,
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
                                    new TextButton.icon(
                                      onPressed: () {},
                                      label: Text(
                                        'DOWNLOAD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.file_download,
                                        color: Colors.white,
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
                                    new TextButton.icon(
                                      onPressed: () {},
                                      label: Text(
                                        'DOWNLOAD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.file_download,
                                        color: Colors.white,
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
                                    new TextButton.icon(
                                      onPressed: () {},
                                      label: Text(
                                        'DOWNLOAD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.file_download,
                                        color: Colors.white,
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
                                    new TextButton.icon(
                                      onPressed: () {},
                                      label: Text(
                                        'DOWNLOAD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.file_download,
                                        color: Colors.white,
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
                                    new TextButton.icon(
                                      onPressed: () {},
                                      label: Text(
                                        'DOWNLOAD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.file_download,
                                        color: Colors.white,
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
                                    new TextButton.icon(
                                      onPressed: () {},
                                      label: Text(
                                        'DOWNLOAD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.file_download,
                                        color: Colors.white,
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
    );
  }
}
