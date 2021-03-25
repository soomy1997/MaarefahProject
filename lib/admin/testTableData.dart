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
      title: 'test',
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
        title: 'test',
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('add_session_request')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            return DataTable(
              columns: [
                DataColumn(label: Text('Session \nID')),
                DataColumn(label: Text('Session \nName')),
                DataColumn(label: Text('Tutor\nName')),
              ],
              rows: _buildList(context, snapshot.data.docs),
              columnSpacing: 20,
            );
          },
        ),
      ),
    );
  }

  List<DataRow> _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return DataRow(cells: [
      DataCell(Text(record.sessionId)),
      DataCell(Text(
        record.sessionName,
      )),
      DataCell(Text(record.tutorName)),
    ]);
  }
}

class Record {
  final String sessionId;
  final String sessionName;
  final String tutorName;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['sessionId'] != null),
        assert(map['sessionName'] != null),
        assert(map['tutorName'] != null),
        sessionId = map['sessionId'],
        sessionName = map['sessionName'],
        tutorName = map['tutorName'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$sessionId:$sessionName:$tutorName>";
}
