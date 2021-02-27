import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/component/home_card.dart';
import 'package:flutter_app_1/component/vertical_list.dart';
//import 'utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CollectionReference session =
      FirebaseFirestore.instance.collection('session');
  var _selectedIndex = 2;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xff14213C),
        actions: [
          new IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            iconSize: 30,
            color: Colors.white,
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
                  // onChanged: (value) {
                  //   filterSearchResults(value);
                  // },
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
            child: VerticalCards(),
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
  }
}
