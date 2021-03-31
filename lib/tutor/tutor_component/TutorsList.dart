import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_1/tutorDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/utils/constants.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: TutorsList(),
//   ));
// }

class TutorsList extends StatefulWidget {
  final Widget child;
  TutorsList({Key key, @required this.child}) : super(key: key);

  @override
  _TutorsList createState() => _TutorsList();
}

class _TutorsList extends State<TutorsList> {
  navigateToTutorDetails(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyTutorDetails(
                  post: post,
                )));
  }

// ignore: must_call_super
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar1(
          context,
          title: "Tutors List",
          iconButton: IconButton(
            icon: Icon(Icons.ios_share),
            onPressed: () {},
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where('role', isEqualTo: 'tutor')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: const Text('Loading events...'));
            }
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(20),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 50,
                            child: Image.network(
                              snapshot.data.docs[index]['avatar_url'],
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(snapshot.data.docs[index]['name'], style: h4),
                          new MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              navigateToTutorDetails(snapshot.data.docs[index]);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  "View Profile ",
                                  style: whiteButtonsTextStyle,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: kTextLightColor,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
              },
              itemCount: snapshot.data.docs.length,
            );
          },
        ));
  }
}
