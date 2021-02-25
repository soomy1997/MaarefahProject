import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';

void main() {
  runApp(TutorProfile());
}

class TutorProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tutor Details',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: myTutorProfile(title: 'Tutor Details'),
    );
  }
}

class myTutorProfile extends StatefulWidget {
  myTutorProfile({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _myTutorProfile createState() => _myTutorProfile();
}

class _myTutorProfile extends State<myTutorProfile> {
  List<Story> _cards;

  @override
  void initState() {
    super.initState();
    _populateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff14213C),
          actions: [
            IconButton(icon: Icon(Icons.close_rounded), onPressed: () => {})
          ],
          title: Text(widget.title),
          leading: Icon(Icons.arrow_back_ios)),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 50,
                    backgroundImage: AssetImage('images/logo.jpg'),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Faizah Saeed',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'CIS Student Level 10',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[300],
                      width: 3.0,
                    ),
                  ),
                ),
                width: 130.0,
                height: 80.0,
                child: Text(
                  'Courses',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      //                   <--- left side
                      color: Colors.grey[300],
                      width: 3.0,
                    ),
                  ),
                ),
                width: 130.0,
                height: 80.0,
                child: Text(
                  'Reviews',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[300],
                      width: 3.0,
                    ),
                  ),
                ),
                width: 130.0,
                height: 80.0,
                child: Text(
                  'Rating',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildCardListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _populateData() {
    _cards = <Story>[
      Story(
          name: 'Data Structure and algorithms Ch. 1',
          storyUrl:
              'https://image.ebooks.com/previews/210/210151/210151347/210151347-hq-168-80.jpg',
          email: 'waleedarshad@gmail.com'),
      Story(
        name: 'Data Structure and algorithms Ch. 2',
        storyUrl:
            'https://image.ebooks.com/previews/210/210151/210151347/210151347-hq-168-80.jpg',
        email: 'flutter.khi@gmail.com',
      ),
      Story(
        name: 'Object-Oriented Programming 1',
        storyUrl:
            'https://image.ebooks.com/previews/209/209521/209521301/209521301-hq-168-80.jpg',
        email: 'flutterkarachi@gmail.com',
      ),
      Story(
        name: 'Object-Oriented Programming 1',
        storyUrl:
            'https://image.ebooks.com/previews/209/209521/209521301/209521301-hq-168-80.jpg',
        email: 'helloworld@gmail.com',
      ),
      Story(
        name: 'Object-Oriented Programming 1',
        storyUrl:
            'https://image.ebooks.com/previews/209/209521/209521301/209521301-hq-168-80.jpg',
        email: 'google@google.com',
      ),
      Story(
        name: 'Object-Oriented Programming 1',
        storyUrl:
            'https://image.ebooks.com/previews/209/209521/209521301/209521301-hq-168-80.jpg',
        email: 'gmail@google.com',
      ),
    ];
  }

  Widget _buildCardListView() {
    return SizedBox(
      height: 250.0,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.horizontal,
        itemCount: _cards.length,
        itemExtent: 180.0,
        itemBuilder: (context, index) {
          var item = _cards[index];
          return Card(
            elevation: 10.0,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          item.storyUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.grey,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                    'Details',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Story {
  final String name;
  final String email;
  final String storyUrl;

  Story({this.name, this.storyUrl, this.email});
}
