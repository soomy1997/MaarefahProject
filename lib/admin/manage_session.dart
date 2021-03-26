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
      title: 'Manage Sessions',
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
      body: Container(
        //
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('add_session_request')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return Column(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(50),
                      child: Text(
                        'Manage sessions',
                        style: h1,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Session \nID')),
                      DataColumn(label: Text('Session \nName')),
                      DataColumn(label: Text('Tutor\nName')),
                      DataColumn(label: Text('Option')),
                    ],
                    rows: _buildList(context, snapshot.data.docs),
                    //columnSpacing: 20,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30, right: 150),
                  child: Material(
                    child: MaterialButton(
                      height: 50,
                      minWidth: 190,
                      color: accentYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
                      child: Text(
                        "Add New Session",
                        textAlign: TextAlign.center,
                        style: yellowButtonsTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
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

    return DataRow(
      cells: [
        DataCell(Text(record.sessionId)),
        DataCell(Text(record.sessionName)),
        DataCell(Text(record.tutorName)),
        DataCell(
          TextButton(
            onPressed: () {},
            child: Text(
              'More',
            ),
          ),
          showEditIcon: true,
        ),
      ],
      selected: true | false,
    );
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
