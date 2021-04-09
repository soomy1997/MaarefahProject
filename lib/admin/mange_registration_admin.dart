import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/add_new_registration.dart';
import 'package:flutter_app_1/utils/constants.dart';

import 'admin_compnent/main_drawer.dart';

class ManageRegistration extends StatefulWidget {
  ManageRegistration({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ManageRegistrationState createState() => _ManageRegistrationState();
}

class _ManageRegistrationState extends State<ManageRegistration> {
  @override
  Widget build(BuildContext context) {
    final addBtn = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(6.0),
      color: accentYellow,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.all(
          15,
        ),
        onPressed: () {},
        child: Text("Add New Registration",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.normal)),
      ),
    );

    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'Manage Registeration',
      ),
      endDrawer: Drawer(
        child: MainDrawer(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('registration')
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
                            'Manage Registeration',
                            style: h1,
                          ),
                        ),
                      ],
                    ),
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Learner name')),
                        DataColumn(label: Text('Session Name')),
                        DataColumn(label: Text('Tutor Name')),
                        DataColumn(label: Text('Edit')),
                        DataColumn(label: Text('Delete')),
                      ],
                      rows: _buildList(context, snapshot.data.docs),
                      //columnSpacing: 20,
                    ),
                  ],
                ),
              );
            },
          ),
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
      DataCell(Text(record.learnerName)),
      DataCell(Text(record.sessionName)),
      DataCell(Text(record.tutorName)),
      DataCell(
        IconButton(
          icon: Icon(
            Icons.edit,
            color: accentYellow,
          ),
          onPressed: () {},
        ),
      ),
      DataCell(
        IconButton(
          icon: Icon(
            Icons.delete,
            color: accentOrange,
          ),
          onPressed: () {},
        ),
      ),
    ]);

    // void _submit() {
    //   Navigator.push(context, MaterialPageRoute(builder: (c) {
    //     return AddNewRegister();
    //   }));
    // }
  }
}

class Record {
  final String learnerName;
  final String sessionName;
  final String tutorName;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['l_name'] != null),
        assert(map['ses_name'] != null),
        assert(map['tutor_name'] != null),
        learnerName = map['l_name'],
        sessionName = map['ses_name'],
        tutorName = map['tutor_name'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$learnerName:$sessionName:$tutorName>";
}
