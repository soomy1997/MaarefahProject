import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CollectionReference session =
      FirebaseFirestore.instance.collection('session');
  var _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xff14213C),
        actions: [
          new IconButton(
            icon: Icon(Icons.search),
            iconSize: 30,
            color: Colors.white,
            onPressed: () => (0),
          ),
          new IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            iconSize: 30,
            color: Colors.white,
            onPressed: () => (0),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 180.0),
        alignment: Alignment.center,
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
                    height: MediaQuery.of(context).size.height / 8,
                    child: new ListTile(
                      title: new Text(document.data()['course_name']),
                      subtitle: new Text(document.data()['ses_name']),
                      isThreeLine: true,
                      leading: new Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/ma-arefah-app.appspot.com/o/9781846289620.jpg?alt=media&token=aba34b32-f91f-48d7-b5d5-a44eb2d7feda"),
                      // trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () => build(context),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
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
  }
}
