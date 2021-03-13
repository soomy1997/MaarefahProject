import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/crud.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TutorProfile());
}

//اسئلة للمبرمجين ليش الفنكشن مقسمة بهالصورة وليش يعضها اكستند ستيت لحالها
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

// ignore: camel_case_types
class myTutorProfile extends StatefulWidget {
  myTutorProfile({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _myTutorProfile createState() => _myTutorProfile();
}

// ignore: camel_case_types
class _myTutorProfile extends State<myTutorProfile> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // CollectionReference tutors = FirebaseFirestore.instance.collection('tutors');
  crudMethods crudObj = new crudMethods();
  List<Story> _cards;
  QuerySnapshot tutors;

  @override
  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        tutors = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var rating = 0.0;
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
                  nameDis(),
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
                width: 110.0,
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
                width: 110.0,
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
                width: 110.0,
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
            child: Container(
              height: 40,
              child: ListView(
                children: <Widget>[
                  _buildCardListView(),
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: SmoothStarRating(
                rating: rating,
                isReadOnly: false,
                size: 40,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                defaultIconData: Icons.star_border,
                starCount: 5,
                allowHalfRating: true,
                spacing: 2.0,
                color: Colors.yellow,
                borderColor: Colors.yellow,
                onRated: (value) {
                  print("rating value -> $value");
                  // print("rating value dd -> ${value.truncate()}");
                },
              )),
        ],
      ),
    );
  }

  Widget nameDis() {
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
                        fit: BoxFit.fitHeight,
                      ),
                      color: Colors.white,
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
