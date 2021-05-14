import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/component/home_card.dart';
import 'package:flutter_app_1/models/users.dart';
import 'package:flutter_app_1/screens/course_details.dart';
import 'package:flutter_app_1/services/database.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {

  //getting current user information
  OurUser _currentUser = OurUser();
  OurUser get getCurrntUser => _currentUser;
  Future<OurUser> getUserInfo() async {
    User _firebaseUser = FirebaseAuth.instance.currentUser;
    _currentUser = await OurDatabase().getuserInfo(_firebaseUser.uid);
    return _currentUser;
  }

  User user;
  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String sesName = "";

  getDetails() async {
    // DateTime _now = DateTime.now();
    // DateTime _start = DateTime(_now.day, _now.month, _now.year, 0, 0);
    // var x = Timestamp.fromDate(_start);
    // final df = new DateFormat('dd-MM-yyyy hh:mm a');
    // int myvalue = 1558432747;
    // print('try 2 : ' +
    //     df.format(new DateTime.fromMillisecondsSinceEpoch(myvalue * 1000)));
    // var realDate =
    //     df.format(new DateTime.fromMillisecondsSinceEpoch(myvalue * 1000));

    // print('this is timestamp' +
    //     DateTime.fromMicrosecondsSinceEpoch(myvalue * 1000).toString());

    var data = await FirebaseFirestore.instance
        .collection('session')
        //.where('time_stamp', isLessThanOrEqualTo: v)
        .where('approved', isEqualTo: "yes")
        .get();
    // .where('session_date',
    //     isGreaterThanOrEqualTo:
    //         new DateTime.now().millisecondsSinceEpoch)
    // print("DOCUMENT SIZE IS LLLL: ");
    // print("this is sintance 3 ");

    return data;
  }

  navigateToCourseDetails(String post, bool isUserRegistered) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetails(
          post: post,
          isUserRegistered: isUserRegistered,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //_data = getDetails();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: myAppBar4(
        context,
        title: '',
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
                      sesName = val;
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
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(15, 20, 0, 15),
            child: Text(
              'Upcoming Sessions',
              style: h4,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future: (sesName != "" && sesName != null)
                      ? FirebaseFirestore.instance
                          .collection('session')
                          .where("searchIndex", arrayContains: sesName)
                          .where("approved", isEqualTo: 'yes')
                          .get()
                      : getDetails(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data.docs.length == 0) {
                      return SizedBox(child: Text('There is no data'));
                    } else {
                      return (snapshot.connectionState ==
                              ConnectionState.waiting)
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot doc =
                                    snapshot.data.docs[index];

                                DateTime myDateTime =
                                    (doc.data()['time_stamp']).toDate();
                                var sesDate = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(myDateTime);
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Card(
                                        child: InkWell(
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                          doc.data()[
                                                              'image_url'],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth: 300),
                                                      child: Text(
                                                        doc.data()['ses_name'],
                                                        style: TextStyle(
                                                          color: primaryBlack,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 17.0),
                                                      child: Text(
                                                        'By: ' +
                                                            doc.data()[
                                                                'tutor_name'],
                                                        style: TextStyle(
                                                          color: primaryBlack,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .calendar_today_outlined,
                                                            size: 18,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Text(
                                                              sesDate,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade800,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () async {
                                            var user = await getUserInfo();
                                            print('session id ' +
                                                snapshot.data
                                                    .docs[index]['sessionId']
                                                    .toString());
                                            print('user id ' + user.uid);

                                            var isUserRegistered =
                                                await isUserRegisteredInSession(
                                                    user.uid,
                                                    snapshot
                                                        .data
                                                        .docs[index]
                                                            ['sessionId']
                                                        .toString());
                                            navigateToCourseDetails(
                                                snapshot.data.docs[index]
                                                    ['sessionId'],
                                                isUserRegistered);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> isUserRegisteredInSession(String uid, String sessionID) async {
    var result = await FirebaseFirestore.instance
        .collection('registration')
        .where('uid', isEqualTo: uid)
        .where('sessionId', isEqualTo: sessionID)
        .get();

    if (result.docs.length == 0) {
      return false; // user is not regsitred in the session
    } else {
      return true; // user is regsitered in the session
    }
  }
}
