import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/screens/contact_us.dart';
import 'package:flutter_app_1/screens/edit_account.dart';
import 'package:flutter_app_1/screens/join_as_tutor.dart';
import 'package:flutter_app_1/models/users.dart';
import 'package:flutter_app_1/root/root.dart';
import 'package:flutter_app_1/services/database.dart';
import 'package:flutter_app_1/services/flutterfire.dart';
import 'package:flutter_app_1/services/database.dart';
import 'package:provider/provider.dart';
import 'About.dart';
import 'package:flutter_app_1/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  OurUser _currentUser = OurUser();
  OurUser _cUser;
  OurUser get getCurrntUser => _currentUser;
  Future<void> getUserInfo() async {
    User _firebaseUser = FirebaseAuth.instance.currentUser;
    _currentUser = await OurDatabase().getuserInfo(_firebaseUser.uid);
    setState(() {
      _cUser = _currentUser;
    });
  }

  User user;
  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar3(
        context,
        title: 'Account',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: containerElement(),
            ),
          ],
        ),
      ),
    );
  }

  containerElement() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: MediaQuery.of(context).size.height * .6,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            custom(),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                ListTile(
                  leading: Icon(
                    Icons.ad_units,
                    color: Colors.orange,
                  ),
                  title: Text("Registered Session",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.lock,
                    color: Colors.greenAccent,
                  ),
                  title: Text("Change Password",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.deepPurple,
                  ),
                  title: Text("Join Us as a tutor Session",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JoinTutorPage()),
                    );
                  },
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Support",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: Colors.amber,
                  ),
                  title: Text("About Us",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.blue[200],
                  ),
                  title: Text("Contact Us",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Account()));
                  },
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      CurrentUser _currentUser =
                          Provider.of<CurrentUser>(context, listen: false);
                      String _returnString = await _currentUser.signOut();
                      if (_returnString == 'success') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OurRout(),
                          ),
                          (route) => false,
                        );
                      } else {}
                    },
                    icon: Icon(Icons.logout),
                    label: Text("Sign Out"),
                    style: ElevatedButton.styleFrom(
                      primary: secondaryDarkGrey,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.switch_account),
                    label: Text("Switch to Tutor"),
                    style: ElevatedButton.styleFrom(
                      primary: accentYellow,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  boxShadow() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.grey[300],
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 6, // soften the shadow
            spreadRadius: 3, //end the shadow
            offset: Offset(
              6.0, // Move to right 10  horizontally
              2.0, // Move to bottom 10 Vertically
            ),
          ),
          BoxShadow(
            color: Color.fromRGBO(255, 255, 255, 0.5),
            blurRadius: 6, // soften the shadow
            spreadRadius: 3, //end the shadow
            offset: Offset(
              -6.0, // Move to right 10  horizontally
              -2.0, // Move to bottom 10 Vertically
            ),
          ),
        ]);
  }

  custom() {
    SizedBox st = SizedBox(
      height: 5,
    );
    SizedBox spacer = SizedBox(
      height: 15,
    );
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(),
            );
          OurUser users = CurrentUser().getCurrntUser;
          return Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.36,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: boxShadow(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: FloatingActionButton(
                              elevation: 0,
                              backgroundColor: Colors.grey[300],
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                    size: 12,
                                  ),
                                  Text(
                                    "Edit",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditAccountPage()),
                                );
                              }),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 40,
                          child: Text(
                            "AB",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        st,
                        Text(
                          'Edit',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        st,
                        Text(
                          'Full Name',
                          style: h4,
                        ),
                        st,
                        Text(
                          '${_cUser.name}',
                          style: h5,
                        ),
                        spacer,
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Gender',
                              style: h4,
                            ),
                            Text(
                              'Level',
                              style: h4,
                            ),
                            Text(
                              'Email',
                              style: h4,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_cUser.gender}',
                              style: h5,
                            ),
                            Text(
                              '                ${_cUser.academicLevel}',
                              style: h5,
                            ),
                            Text(
                              '${_cUser.email}',
                              style: h5,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
