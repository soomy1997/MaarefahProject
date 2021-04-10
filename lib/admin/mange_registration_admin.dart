import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/add_new_registration.dart';
import 'package:flutter_app_1/admin/admin_compnent/dialogs.dart';
import 'package:flutter_app_1/utils/constants.dart';

import 'admin_compnent/main_drawer.dart';

class ManageRegistration extends StatefulWidget {
  ManageRegistration({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ManageRegistrationState createState() => _ManageRegistrationState();
}

class _ManageRegistrationState extends State<ManageRegistration> {
  bool sort;
  @override
  Widget build(BuildContext context) {
    final addBtn = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(6.0),
      color: accentYellow,
      child: MaterialButton(
        height: 50,
        minWidth: 190,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _submit();
        },
        child: Text("Add New Registration",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
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
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 230),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(50),
                              child: Text(
                                'Manage Registeration',
                                style: h1,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(50),
                              child: addBtn,
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataTable(
                      showCheckboxColumn: false,
                      columns: [
                        DataColumn(label: Text('Register Id')),
                        DataColumn(label: Text('Learner name')),
                        DataColumn(label: Text('Session Name')),
                        DataColumn(label: Text('Session Id')),
                        DataColumn(label: Text('Tutor Name')),
                        DataColumn(label: Text('Edit')),
                        DataColumn(label: Text('Delete')),
                      ],
                      rows: _buildList(context, snapshot.data.docs),
                      sortColumnIndex: 0,
                      sortAscending: true,
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
    String _getSelectedRowId(String regId) {
      print('sessionId:$regId');
      return regId;
    }

    return DataRow(
      cells: [
        DataCell(Text(record.regId)),
        DataCell(Text(record.learnerName)),
        DataCell(Text(record.sessionName)),
        DataCell(Text(record.sessionId)),
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
          Icon(
            Icons.delete,
            color: accentOrange,
          ),
          onTap: () async {
            _getSelectedRowId(record.sessionId);
            final action = await WarningDialogs.yesAbortDialog(
                context,
                "Warning",
                "Are you sure you want to \ndelete the learner's registeration?");
            if (action == DialogAction.yes) {
              setState(
                () => FirebaseFirestore.instance
                    .collection('registration')
                    .where('reg_id', isEqualTo: _getSelectedRowId(record.regId))
                    .get()
                    .then((value) {
                  value.docs.forEach((element) {
                    element.reference.delete().then((value) {
                      print('Success!');
                    });
                  });
                }),
              );
            } else {
              setState(() => null);
            }
          },
        ),
      ],
      onSelectChanged: (newValue) {
        print('row 2 pressed');
      },
    );
  }

  void _submit() {
    Navigator.push(context, MaterialPageRoute(builder: (c) {
      return AddNewRegister();
    }));
  }
}

class Record {
  final String regId;
  final String sessionId;
  final String learnerName;
  final String sessionName;
  final String tutorName;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['reg_id'] != null),
        assert(map['l_name'] != null),
        assert(map['ses_name'] != null),
        assert(map['sessionId'] != null),
        assert(map['tutor_name'] != null),
        regId = map['reg_id'],
        learnerName = map['l_name'],
        sessionName = map['ses_name'],
        sessionId = map['sessionId'],
        tutorName = map['tutor_name'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() =>
      "Record<$regId:$learnerName:$sessionName:$sessionId:$tutorName>";
}
