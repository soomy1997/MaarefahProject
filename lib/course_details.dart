import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text(
              'Session Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Color(0xff14213C),
            leading: GestureDetector(
              onTap: () {},
              child: Icon(Icons.arrow_back_ios_sharp),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.ios_share),
                ),
              )
            ]),
        body: Column(children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, bottom: 40),
              child: Text(
                "Course Name",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  height: 50,
                  minWidth: 200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  onPressed: () {},
                  child: Text(
                    ' Register Session',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orangeAccent[400]),
              SizedBox(
                width: 10,
              ),
              FlatButton(
                  height: 50,
                  minWidth: 200,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: Colors.black54)),
                  child: Text(
                    ' Add to Calendar',
                    style: TextStyle(color: Colors.orangeAccent[400]),
                  ),
                  color: Colors.white)
            ],
          ),
          Expanded(
            child: _buildListView(),
          ),
        ]),
      ),
    );
  }

  ListView _buildListView() {
    return new ListView(
      children: <Widget>[
        Card(
          child: Stack(
            children: [
              ListTile(
                  contentPadding: EdgeInsets.only(top: 0, bottom: 50, left: 0),
                  title: Text(
                    'Description',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              ListTile(
                contentPadding: EdgeInsets.only(top: 50, bottom: 0, left: 0),
                subtitle: Text(
                    ' Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 17)),
              )
            ],
          ),
        ),
        Card(
          child: Stack(
            children: [
              ListTile(
                  contentPadding: EdgeInsets.only(top: 0, bottom: 50, left: 0),
                  title: Text(
                    'Agenda',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              ListTile(
                contentPadding: EdgeInsets.only(top: 50, bottom: 0, left: 0),
                subtitle: Text(
                    ' Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 17)),
              )
            ],
          ),
        ),
        Card(
          child: Stack(
            children: [
              ListTile(
                  contentPadding: EdgeInsets.only(top: 0, bottom: 50, left: 0),
                  title: Text(
                    'Requirements',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              ListTile(
                contentPadding: EdgeInsets.only(top: 50, bottom: 0, left: 0),
                subtitle: Text(
                    ' Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 17)),
              )
            ],
          ),
        ),
        Card(
          child: Stack(
            children: [
              ListTile(
                  contentPadding: EdgeInsets.only(top: 0, bottom: 50, left: 0),
                  title: Text(
                    'Attatchments',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              ListTile(
                contentPadding: EdgeInsets.only(top: 50, bottom: 0, left: 0),
                subtitle: Text(
                    ' Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 17)),
              )
            ],
          ),
        ),
        Card(
          child: Stack(
            children: [
              ListTile(
                  contentPadding: EdgeInsets.only(top: 0, bottom: 50, left: 0),
                  title: Text(
                    'Tutor Overview',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              ListTile(
                contentPadding: EdgeInsets.only(top: 50, bottom: 0, left: 0),
                leading: Icon(Icons.cast_for_education_sharp),
                subtitle: Text(
                    ' Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 17)),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(top: 100, bottom: 15, left: 10),
                title: Text('Read more',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.orangeAccent[400])),
                trailing: Icon(Icons.arrow_forward),
              )
            ],
          ),
        ),
      ],
    );
  }
}
