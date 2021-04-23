import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/component/home_card.dart';
import 'package:flutter_app_1/screens/course_details.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String sesName = "";

  Stream _data;
  Stream getDetails() {
    return FirebaseFirestore.instance
        .collection('session')
        .where('approved', isEqualTo: 'yes')
        .snapshots();
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
            child: Text(
              'Current Sessions',
              style: h4,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            //child: VerticalCards(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: (sesName != "" && sesName != null)
                    ? FirebaseFirestore.instance
                        .collection('session')
                        .where("searchIndex", arrayContains: sesName)
                        .where("approved", isEqualTo: 'yes')
                        .snapshots()
                    : _data,
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data.docs[index];
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
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                      doc.data()['image_url'],
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
                                                  constraints: BoxConstraints(
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
                                                          "${doc.data()['ses_date']}",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey.shade800,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15.0),
                                                        child: Icon(
                                                          Icons.access_time,
                                                          size: 18,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5.0),
                                                        child: Text(
                                                          doc.data()[
                                                              'session_time'],
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey.shade800,
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
                                      onTap: () {
                                        navigateToCourseDetails(
                                          snapshot.data.docs[index],
                                        );
                                      },
                                    ),
                                  ),
                                ],
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
