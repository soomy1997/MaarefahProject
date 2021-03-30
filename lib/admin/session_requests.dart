import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/admin_session_details.dart';
import 'package:flutter_app_1/utils/constants.dart';

class SessionRequestPage extends StatefulWidget {
  @override
  _SessionRequestPageState createState() => _SessionRequestPageState();
}

class _SessionRequestPageState extends State<SessionRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar1(context,
          title: 'Sessions Requests',
          iconButton: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 40,
            onPressed: () => (0),
          )),
      body: Container(
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
                        'Sessions Requests',
                        style: h1,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Session ID')),
                      DataColumn(label: Text('Session Name')),
                      DataColumn(label: Text('Tutor Name')),
                      DataColumn(label: Text('Option')),
                    ],
                    rows: _buildList(context, snapshot.data.docs),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SessionDetailsPage(id: record.sessionId)),
              );
            },
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
