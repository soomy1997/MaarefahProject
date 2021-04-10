import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/edit_session_details.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'admin_compnent/main_drawer.dart';

class ManageSessionsPage extends StatefulWidget {
  @override
  _ManageSessionsPageState createState() => _ManageSessionsPageState();
}

class _ManageSessionsPageState extends State<ManageSessionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'Manage Sessions',
      ),
      endDrawer: Drawer(
        child: MainDrawer(),
      ),
      body: Container(
        //
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('session')
              .where('approved', isEqualTo: 'yes')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return Center(
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(50),
                        child: Text(
                          'Manage Sessions',
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
                      //columnSpacing: 20,
                    ),
                  ),
                ],
              ),
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
                        EditSessionDetailsPage(id: record.sessionId)),
              );
            },
            child: Text(
              'More',
            ),
          ),
          showEditIcon: true,
        ),
      ],
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
        assert(map['ses_name'] != null),
        assert(map['tutor_name'] != null),
        sessionId = map['sessionId'],
        sessionName = map['ses_name'],
        tutorName = map['tutor_name'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$sessionId:$sessionName:$tutorName>";
}
