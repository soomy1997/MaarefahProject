import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/screens/registered_sessions.dart';
import 'package:flutter_app_1/screens/change_password.dart';
import 'package:flutter_app_1/screens/contact_us.dart';
import 'package:flutter_app_1/screens/edit_account.dart';
import 'package:flutter_app_1/screens/join_as_tutor.dart';
import 'package:flutter_app_1/models/users.dart';
import 'package:flutter_app_1/root/root.dart';
import 'package:flutter_app_1/services/database.dart';
import 'package:flutter_app_1/services/flutterfire.dart';
import 'package:provider/provider.dart';
import 'About.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:flutter_app_1/tutor/taught_sessions.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  OurUser _currentUser = OurUser();
  OurUser _cUser = OurUser();

  Future<void> currentUserInfo() async {
    User _firebaseUser = FirebaseAuth.instance.currentUser;
    _currentUser = await OurDatabase().getuserInfo(_firebaseUser.uid);

    setState(() {
      _cUser = _currentUser;
    });
  }

  @override
  void initState() {
    super.initState();
    currentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar4(
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
              child: StreamBuilder<User>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData && snapshot.data != null) {
                    CurrentUser.saveUser(snapshot.data);
                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(snapshot.data.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final userDoc = snapshot.data;
                        final user = userDoc.data();
                        if (user['role'] == 'learner' ||
                            user['role'] == 'pending tutor') {
                          return learnerContainerElement();
                        } else {
                          return tutorContainerElement();
                        }
                      },
                    );
                  }
                  return tutorContainerElement();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tutorContainerElement() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            customTutor(),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                ListTile(
                  leading: Icon(
                    Icons.photo_camera_front,
                    color: Colors.blue[800],
                  ),
                  title: Text("My zoom link",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.collections_bookmark_rounded,
                    color: Colors.orange,
                  ),
                  title: Text("Taught sessions",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaughtSessions()),
                    );
                  },
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangePassword()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.rate_review_outlined,
                    color: Colors.deepPurple,
                  ),
                  title: Text("Reviews & Ratings",
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
                ListTile(
                  leading: Icon(Icons.card_membership_outlined,
                      color: Colors.brown[200]),
                  title: Text("Certifications",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  onTap: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinTutorPage()),
                      );*/
                  },
                ),
                // Container(
                //     margin: EdgeInsets.symmetric(horizontal: 20),
                //     child: Text(
                //       "Support",
                //       style: TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     )),
                // ListTile(
                //   leading: Icon(
                //     Icons.location_on_outlined,
                //     color: Colors.red,
                //   ),
                //   title: Text("About Us",
                //       style: TextStyle(
                //         fontSize: 16,
                //       )),
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => AboutPage()));
                //   },
                // ),
                // ListTile(
                //   leading: Icon(
                //     Icons.email,
                //     color: Colors.blue[200],
                //   ),
                //   title: Text("Contact Us",
                //       style: TextStyle(
                //         fontSize: 16,
                //       )),
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => Account()));
                //   },
                // ),
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
                        icon: Icon(
                          Icons.logout,
                          color: whiteBG,
                        ),
                        label: Text(
                          "Sign Out",
                          style: yellowButtonsTextStyle,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: accentOrange,
                        ),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }

  Widget learnerContainerElement() {
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisteredSessions()));
                  },
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangePassword()),
                    );
                  },
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
                    icon: Icon(
                      Icons.logout,
                      color: whiteBG,
                    ),
                    label: Text(
                      "Sign Out",
                      style: yellowButtonsTextStyle,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: accentOrange,
                    ),
                  ),
                  //ElevatedButton.icon(
                  //  onPressed: () {},
                  //  icon: Icon(
                  //    Icons.switch_account,
                  //    color: whiteBG,
                  //  ),
                  //  label: Text(
                  //    "Switch to Tutor",
                  //    style: yellowButtonsTextStyle,
                  //  ),
                  //  style: ElevatedButton.styleFrom(
                  //    primary: accentYellow,
                  //  ),
                  //),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 50),
                        child: Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 50,
                            child: Text(
                              "AB",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt_rounded),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                  st,
                  Text(
                    '${_cUser.name}',
                    style: h4,
                  ),
                  st,
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
  }

  Widget customTutor() {
    SizedBox st = SizedBox(
      height: 5,
    );
    SizedBox spacer = SizedBox(
      height: 5,
    );

    TextStyle style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    TextStyle styles = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    TextStyle valueStyle = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    TextStyle editStyle = TextStyle(
      color: Colors.orange,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    Text name = Text(
      "${_cUser.name}",
      style: style,
    );

    Text edit = Text(
      "Edit",
      style: editStyle,
    );
    // Text learner = Text(
    //   "${_cUser.name}",
    //   style: valueStyle,
    // );

    Text gender = Text(
      "Gender",
      style: styles,
    );
    Text genderValue = Text(
      "${_cUser.gender}",
      style: valueStyle,
    );

    Text acaLevel = Text(
      "Academic Level",
      style: styles,
    );
    Text acaValue = Text(
      "${_cUser.academicLevel}",
      style: valueStyle,
    );

    Text email = Text(
      "Email",
      style: styles,
    );
    Text emailValue = Text(
      "${_cUser.email}",
      style: valueStyle,
    );

    Text phone = Text(
      "Phone Number",
      style: styles,
    );
    Text phoneValue = Text(
      "${_cUser.phoneNum}",
      style: valueStyle,
    );

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

    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
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
                  backgroundColor: Color(0XFFdae1eb),
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
                  },
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  "AB",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              st,
              edit,
              st,
              name,
              st,
              spacer,

              Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [acaLevel, acaValue, gender, genderValue],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [email, emailValue, phone, phoneValue],
                  )
                ],
              ), // Him
            ],
          ),
        ),
      ),
    );
  }
}
