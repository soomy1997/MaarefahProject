import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_1/TutorCard.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TutorsList(),
  ));
}

class TutorsList extends StatefulWidget {
  final Widget child;
  TutorsList({Key key, @required this.child}) : super(key: key);

  @override
  _TutorsList createState() => _TutorsList();
}

class _TutorsList extends State<TutorsList> {
  // CrudMethods crudObj = new CrudMethods();
  // QuerySnapshot tutors;
  Stream _data;
  Stream getDetails() {
    return FirebaseFirestore.instance.collection('tutors').snapshots();
  }

// ignore: must_call_super
  @override
  void initState() {
    super.initState();
    _data = getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff14213C),
            actions: [
              IconButton(icon: Icon(Icons.close_rounded), onPressed: () => {})
            ],
            title: Text('Tutors List'),
            leading: Icon(Icons.arrow_back_ios)),
        body: Container(
            child: TutorCard(
          child: Text("hi"),
        ))

        //  Container(
        //   child: StreamBuilder(
        //     stream: _data,
        //     builder: (context, snapshot) {
        //       return (snapshot.connectionState == ConnectionState.waiting)
        //           ? Center(child: CircularProgressIndicator())
        //           : ListView.builder(
        //               itemCount: snapshot.data.docs.length,
        //               itemBuilder: (context, index) {
        //                 DocumentSnapshot doc = snapshot.data.docs[index];
        //                 return Card(
        //                   child: Container(
        //                     //width: MediaQuery.of(context).size.width,
        //                     //height: MediaQuery.of(context).size.height / 9,
        //                     child: new TutorCard(
        //                       child: Text(doc.data()['t_fname']),
        //                       //subtitle: new Text(doc.data()['t_lname']),
        //                       //isThreeLine: true,
        //                       //onTap: () {
        //                       //navigateToCourseDetails(
        //                       //  snapshot.data.docs[index]);
        //                       //},
        //                     ),
        //                   ),
        //                 );
        //               },
        //             );
        //     },
        //   ),
        // )

        // AnimationLimiter(
        //   child: ListView.builder(
        //     itemCount: 10,
        //     itemBuilder: (BuildContext context, int index) {
        //       return AnimationConfiguration.staggeredList(
        //         position: index,
        //         duration: const Duration(milliseconds: 375),
        //         child: SlideAnimation(
        //           verticalOffset: 50.0,
        //           child: FadeInAnimation(
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 infodisplay(),
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        );
  }

  // Widget infodisplay() {
  //   if (tutors != null) {
  //     return ListView.builder(
  //       itemCount: tutors.docs.length,
  //       itemBuilder: (context, i) {
  //         return Row(
  //           children: [
  //             Text(tutors.docs[i].data()['t_fname']),
  //             Text(tutors.docs[i].data()['t_lname']),
  //           ],
  //         );
  //       },
  //     );
  //   } else {
  //     return Text('Loading.. Please wait..');
  //   }
  // }
}
