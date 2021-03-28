import 'package:flutter/material.dart';

class CertificateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.orangeAccent[400],
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
                      style: new TextStyle(color: Colors.white, fontSize: 16),
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
                )),
      ),
    );
  }
}
    