import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ManageTutoingRequest());
}

class ManageTutoingRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tutoring Requests',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ManageTutoingRequestPage(),
    );
  }
}

class ManageTutoingRequestPage extends StatefulWidget {
  @override
  _ManageTutoingRequestState createState() => _ManageTutoingRequestState();
}

class _ManageTutoingRequestState extends State<ManageTutoingRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar3(
        context,
        title: 'Tutoring Requests',
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tutoring_request')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return Column(
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 90, 40),
                      child: Text(
                        'Manage Tutoring Requests',
                        style: h1,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 0, top: 30, right: 90),
                  child: Center(
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            'Applicant \nName',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Option')),
                      ],
                      rows: _buildList(context, snapshot.data.docs),
                      // columnSpacing: 30,
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

    return DataRow(cells: [
      DataCell(Text(record.name)),
      DataCell(Text(record.email)),
      DataCell(TextButton(onPressed: () {}, child: Text('More'))),
    ]);
  }
}

class Record {
  final String name;
  final String email;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['email'] != null),
        name = map['name'],
        email = map['email'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$email>";
}
