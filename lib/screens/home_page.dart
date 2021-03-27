import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/component/home_card.dart';
import 'package:flutter_app_1/screens/course_details.dart';
import 'package:flutter_app_1/utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String courseName = "";

  Stream _data;
  Stream getDetails() {
    return FirebaseFirestore.instance.collection('session').snapshots();
  }

  navigateToCourseDetails(DocumentSnapshot post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetails(
          post: post,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _data = getDetails();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: secondaryDarkBlue,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          new IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            iconSize: 40,
            onPressed: () => (0),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      courseName = val;
                    });
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => searchController.clear(),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    hintText: 'Search here!',
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: HomeCard(),
          ),
          Expanded(
            //child: VerticalCards(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: (courseName != "" && courseName != null)
                    ? FirebaseFirestore.instance
                        .collection('session')
                        .where("searchIndex", arrayContains: courseName)
                        .snapshots()
                    : _data,
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data.docs[index];
                            return Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 9,
                                child: new ListTile(
                                  title: new Text(doc.data()['course_name']),
                                  subtitle: new Text(doc.data()['ses_name']),
                                  isThreeLine: true,
                                  leading: new Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/ma-arefah-app.appspot.com/o/" +
                                        doc.data()['image_name'] +
                                        "?alt=media&token=" +
                                        doc.data()['imageToken'],
                                    width: 40,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                  onTap: () {
                                    navigateToCourseDetails(
                                      snapshot.data.docs[index],
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
