import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/component/home_card.dart';
import 'package:flutter_app_1/course_details.dart';
import 'package:flutter_app_1/notification.dart';
import 'package:flutter_app_1/profile.dart';
//import 'package:flutter_app_1/component/vertical_list.dart';
import 'package:flutter_app_1/utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String courseName = "";
  var _selectedIndex = 2;
  Stream _data;
  static List<Widget> _tabViews = <Widget>[HomePage(), NotificationPage(), Profile()];

  Stream getDetails() {
    return FirebaseFirestore.instance.collection('session').snapshots();
  }

  navigateToCourseDetails(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CourseDetails(
                  post: post,
                )));
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
                                        snapshot.data.docs[index]);
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Tutors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.military_tech_outlined),
            label: 'Award List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
        iconSize: 30,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: onItemPressed,
      ),
    );
  }

  onItemPressed(index) {
    if (index != _selectedIndex) {
      setState(() => _selectedIndex = index);
    }
  } //Now using
}
