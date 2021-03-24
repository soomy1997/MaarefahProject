import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TestTable());
}

class TestTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test table',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TestTablePage(),
    );
  }
}

class TestTablePage extends StatefulWidget {
  @override
  _TestTableState createState() => _TestTableState();
}

class _TestTableState extends State<TestTablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar3(
        context,
        title: 'test table',
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('add_session_request')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();

              return Table(
                children: (Session as List)
                    .map(
                      (item) => TableRow(
                        children: [
                          Text(item['id'].toString()),
                          Text(item['report_id'].toString()),
                          Text(item['place']),
                          // you can have more properties of course
                        ],
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Session {
  String sessionID;
  String sessionName;
  String tutorName;

  Session({
    this.sessionID,
    this.sessionName,
    this.tutorName,
  });

  Session.fromDocumentSnapshot({DocumentSnapshot doc}) {
    sessionID = doc.data()['sessionID'];
    sessionName = doc.data()['sessionName'];
    tutorName = doc.data()['tutorName'];
  }
}
