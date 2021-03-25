import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/TutorsList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/crud.dart';
import 'utils/constants.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(TutorDetails());
// }

class TutorDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: myTutorDetails(),
    );
  }
}

// ignore: camel_case_types
class myTutorDetails extends StatefulWidget {
  DocumentSnapshot post;

  myTutorDetails({
    this.post,
  });

  @override
  _myTutorDetails createState() => _myTutorDetails();
}

final _formKey = GlobalKey<FormState>();

// ignore: camel_case_types
class _myTutorDetails extends State<myTutorDetails> {
  String reviewtxt;

  Stream getSessionsByTutor() {
    var tname = widget.post.data()['tutor_name'];
    return FirebaseFirestore.instance
        .collection('session')
        .where(
          "tutor_name",
          isEqualTo: tname,
        )
        .snapshots();
  }

  String getCount() {
    return getSessionsByTutor().length.toString();
  }

  Future<int> countDocuments() async {
    var tname = widget.post.data()['tutor_name'];
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection('session')
        .where(
          "tutor_name",
          isEqualTo: tname,
        )
        .get();
    return _myDoc.size; // Count of Documents in Collection
  }

  @override
  // ignore: must_call_super
  void initState() {}

  @override
  Widget build(BuildContext context) {
    var rating = 0.0;
    return Scaffold(
      appBar: myAppBar1(
        context,
        title: "Tutor Details",
        iconButton: IconButton(
          icon: Icon(Icons.ios_share),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40,
                      backgroundImage: AssetImage('images/logo.jpg'),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    //margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.fromLTRB(4, 20, 4, 20),
                    width: 300,
                    height: 70,
                    child: Text(widget.post.data()['tutor_name'],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  )
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
                child: Text('Courses: ' + 5.toString()),
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text("What is your rate?",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SmoothStarRating(
                              rating: rating,
                              isReadOnly: false,
                              size: 35,
                              filledIconData: Icons.star,
                              halfFilledIconData: Icons.star_half,
                              defaultIconData: Icons.star_border,
                              starCount: 5,
                              allowHalfRating: true,
                              spacing: 1.0,
                              color: Colors.yellow,
                              borderColor: Colors.yellow,
                              onRated: (value) {
                                print("rating value -> $value");
                                // print("rating value dd -> ${value.truncate()}");
                              },
                            )),
                        Text("Write your experience with this tutor:",
                            style: h5),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 70,
                              ),
                              child: TextFormField(
                                  maxLines: 5,
                                  obscureText: false,
                                  style: h5,
                                  validator: textReviewValidation,
                                  onSaved: (value) {
                                    reviewtxt = value;
                                  },
                                  decoration: textInputDecoratuon.copyWith(
                                    hintText: 'Your Review',
                                  ))),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(100, 0, 100, 20),
                            child: RaisedButton(
                              color: Color(0xffF9A21B),
                              onPressed: () {},
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 18.0, 15.0, 18.0),
                              child: Text(
                                'Send Review',
                                style: yellowButtonsTextStyle,
                              ),
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
      ),
    );
  }

  Widget _buildCardListView() {
    var x = getSessionsByTutor();

    // var tname = widget.post.data()['tutor_name'];
    // var x = FirebaseFirestore.instance
    //     .collection('session')
    //     .where(
    //       "tutor_name",
    //       isEqualTo: tname,
    //     )
    //     .snapshots();

    return SizedBox(
        height: 200.0,
        child: StreamBuilder(
          stream: x,
          builder: (context, snapshot) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.docs.length,
              itemExtent: 180.0,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data.docs[index];
                return Card(
                  elevation: 10.0,
                  margin: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
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
                                "https://firebasestorage.googleapis.com/v0/b/ma-arefah-app.appspot.com/o/" +
                                    doc.data()['image_name'] +
                                    "?alt=media&token=" +
                                    doc.data()['imageToken'],
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          doc.data()['course_name'],
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}

class Int {}

class Story {
  final String name;
  final String storyUrl;
  Story({this.name, this.storyUrl});
}
