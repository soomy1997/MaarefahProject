import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/home_page.dart';

class VerticalCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('session')
              .snapshots(includeMetadataChanges: true),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 9,
                    child: new ListTile(
                      title: new Text(document.data()['course_name']),
                      subtitle: new Text(document.data()['ses_name']),
                      isThreeLine: true,
                      leading: new Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/ma-arefah-app.appspot.com/o/" +
                              document.data()['image_name'] +
                              "?alt=media&token=" +
                              document.data()['imageToken']),
                      onTap: () => build(context),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
