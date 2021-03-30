// import 'dart:async';
// import 'package:firebase_database/firebase_database.dart';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/tutor/tutor_component/TutorsList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/crud.dart';
import 'package:flutter_app_1/models/users.dart';
import 'package:flutter_app_1/component/Reviews_card.dart';
import 'package:flutter_app_1/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String reviewtxt, headline;
  var rating = 0.0;
  OurUser _currentUser = OurUser();
  OurUser _cUser;
  OurUser get getCurrntUser => _currentUser;

  Future<void> getUserInfo() async {
    User _firebaseUser = FirebaseAuth.instance.currentUser;
    _currentUser = await OurDatabase().getuserInfo(_firebaseUser.uid);
    setState(() {
      _cUser = _currentUser;
    });
    print(_cUser);
  }

  Stream getSessionsByTutor() {
    var tname = widget.post.data()['name'];
    Stream<QuerySnapshot> x = FirebaseFirestore.instance
        .collection('session')
        .where(
          "tutor_name",
          isEqualTo: tname,
        )
        .snapshots();

    return x;
  }

  int DocCount = 0;
  Future<void> countDocuments() async {
    var tname = widget.post.data()['name'];
    QuerySnapshot x = await FirebaseFirestore.instance
        .collection('session')
        .where(
          "tutor_name",
          isEqualTo: tname,
        )
        .get();
    setState(() {
      DocCount = x.docs.length;
    });
    print(DocCount);
  }

  int DocCount2 = 0;
  Future<void> countDocuments2() async {
    var tname = widget.post.data()['name'];
    QuerySnapshot x = await FirebaseFirestore.instance
        .collection('ratings')
        .where(
          "tutor_name",
          isEqualTo: tname,
        )
        .get();
    setState(() {
      DocCount2 = x.docs.length;
    });
    print(DocCount2);
  }

  // getRating() {
  //   Stream<QuerySnapshot> y =
  //       FirebaseFirestore.instance.collection('ratings').snapshots();
  //   var total = 0.0;
  //   // y.forEach((element) {
  //   //   total += y.data.docs['tutor_name'];
  //   // });
  //   for (var i = 0; i < 5; i++) {
  //     total += y.data.docs[i]('rating');
  //   }
  // }

//   void onDataChange(DataSnapshot dataSnapshot) {

//     var total = 0.0;

//     for (DataSnapshot ds : dataSnapshot.getChildren()){
//         long rating = Double.parseDouble(ds.child("Rating").getValue(Long.class));
//         total = total + rating;
//     }
//     double average = (double)total / dataSnapshot.getChildrenCount();
// }

  @override
  // ignore: must_call_super
  void initState() {
    countDocuments();
    countDocuments2();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    countDocuments();
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
                      backgroundImage:
                          NetworkImage(widget.post.data()['avatar_url']),
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
                    child: Text(widget.post.data()['name'],
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DocCount.toString(), style: h4),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Courses', style: style),
                      ],
                    ),
                  ],
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DocCount2.toString(), style: h4),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Reviews', style: style),
                      ],
                    ),
                  ],
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(4.5.toString(), style: h4),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Reviews', style: style),
                      ],
                    ),
                  ],
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
                  //CardOne(),
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
                                rating = value;
                                print("rating value -> $value");
                                // print("rating value dd -> ${value.truncate()}");
                              },
                            )),
                        Text("How was your experience with this tutor?",
                            style: h5),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 70,
                              ),
                              child: Column(
                                children: [
                                  TextFormField(
                                      obscureText: false,
                                      style: h5,
                                      validator: textReviewValidation,
                                      onSaved: (value) {
                                        headline = value;
                                      },
                                      decoration: textInputDecoratuon.copyWith(
                                        hintText: 'Headline',
                                      )),
                                  TextFormField(
                                      maxLines: 5,
                                      obscureText: false,
                                      style: h5,
                                      validator: textReviewValidation,
                                      onSaved: (value) {
                                        reviewtxt = value;
                                      },
                                      decoration: textInputDecoratuon.copyWith(
                                        hintText: 'Your Review',
                                      )),
                                ],
                              )),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(100, 0, 100, 20),
                            child: MaterialButton(
                              color: Color(0xffF9A21B),
                              onPressed: _sendToServer,
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

//   void calculateRating() {
//     // var total = 0;
//     // Stream<QuerySnapshot> x =
//     //     FirebaseFirestore.instance.collection('ratings').snapshots();
//     // x.forEach(function(x){
//     //   total += x.val().rating;
//     // });
//     var _db=FirebaseFirestore.instance.collection('ratings').snapshots();
//     _db.forEach((QuerySnapshot snapshot) {
//    Map<dynamic, dynamic> values=snapshot.docs;
//    print(values.toString());
//      values.forEach((k,v) {
//         print(k);
//         print(v["name"]);
//      });
//  });
//   }

  void _sendToServer() {
    if (_formKey.currentState.validate()) {
      //No error in validator
      _formKey.currentState.save();
      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('ratings');
        await reference.add({
          'headline': '$headline',
          'body': '$reviewtxt',
          'l_name': _cUser.name,
          'tutor_name': widget.post.data()['tutor_name'],
          'rating': '$rating',
        });
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorsList(),
        ),
      );
    } else {
      setState(() {
        return AutovalidateMode.disabled;
      });
    }
  }

  Widget _buildCardListView() {
    var x = getSessionsByTutor();

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
                              image: NetworkImage(doc.data()['image_url']),
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
