import 'package:flutter/material.dart';
import 'package:flutter_app_1/TutorProfile.dart';
import 'services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TutorCard extends StatefulWidget {
  final Widget child;
  TutorCard({Key key, @required this.child}) : super(key: key);
  @override
  _TutorCardState createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  Stream _data;
  Stream getDetails() {
    return FirebaseFirestore.instance.collection('tutors').snapshots();
  }

  navigateToCourseDetails(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => myTutorProfile(
                  post: post,
                )));
  }

// ignore: must_call_super
  @override
  void initState() {
    super.initState();
    _data = getDetails();
  }

  // CrudMethods crudObj = new CrudMethods();
  // QuerySnapshot tutors;

  // @override
  // // ignore: must_call_super
  // void initState() {
  //   crudObj.getData().then((results) {
  //     setState(() {
  //       tutors = results;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _data,
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data.docs[index];
                    return Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 40,
                        ),
                        widget.child,
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 9,
                            child: new ListTile(
                              title: Text(doc.data()['t_fname']),
                              subtitle: Text(doc.data()['t_lname']),
                              isThreeLine: true,
                              onTap: () {
                                navigateToCourseDetails(
                                    snapshot.data.docs[index]);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
//    Column(
//       //mainAxisSize: MainAxisSize.max,
//       children: [
//         Card(
//           //margin: EdgeInsets.all(40),
//           color: Colors.white,
//           child: Container(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.grey,
//                   radius: 40,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 callinginfo(),

//                 //infodis(),
//                 //starshape(),
//                 //widget.child,
//               ],
//             ),
//           ),
//         )
//       ]);
// }

//   Widget infodis() {
//     if (tutors != null) {
//       return ListView.builder(
//         itemCount: tutors.docs.length,
//         itemBuilder: (context, i) {
//           return ListTile(
//             title: Text(tutors.docs[i].data()['t_fname']),
//             subtitle: Text(tutors.docs[i].data()['t_lname']),
//           );
//         },
//       );
//     } else {
//       return Text("Loading..");
//     }
//   }
// }

// starshape() {
//   return Padding(
//     padding: const EdgeInsets.only(top: 10),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.star,
//           color: Colors.yellow,
//           size: 30.0,
//         ),
//         Icon(
//           Icons.star,
//           color: Colors.yellow,
//           size: 30.0,
//         ),
//         Icon(
//           Icons.star,
//           color: Colors.yellow,
//           size: 30.0,
//         ),
//         Icon(
//           Icons.star,
//           color: Colors.yellow,
//           size: 30.0,
//         ),
//       ],
//     ),
//   );
// }
