import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/component/dialogs.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'admin_compnent/main_drawer.dart';

class ApproveRejTutoringReq extends StatefulWidget {
  final String id;
  ApproveRejTutoringReq({@required this.id});
  @override
  _ApproveRejTutoringReqState createState() =>
      _ApproveRejTutoringReqState(id: this.id);
}

class _ApproveRejTutoringReqState extends State<ApproveRejTutoringReq> {
  final String id;
  _ApproveRejTutoringReqState({@required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar2(context, title: 'Tutoring Requests'),
      endDrawer: Drawer(
        child: MainDrawer(),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: this.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.network(
                          snapshot.data.docs.single['avatar_url'],
                          fit: BoxFit.scaleDown,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        snapshot.data.docs.single['name'],
                        style: h4,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Academic Level',
                            style: h4,
                          ),
                          Text(
                            snapshot.data.docs.first.data()['academicLevel'],
                            style: h5,
                          ),
                        ],
                      ),
                      Divider(),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style: h4,
                          ),
                          Text(
                            snapshot.data.docs.first.data()['email'],
                            style: h5,
                          ),
                        ],
                      ),
                      Divider(),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gender',
                            style: h4,
                          ),
                          Text(
                            snapshot.data.docs.first.data()['gender'],
                            style: h5,
                          ),
                        ],
                      ),
                      Divider(),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone Number',
                            style: h4,
                          ),
                          Text(
                            snapshot.data.docs.first.data()['phoneNum'],
                            style: h5,
                          ),
                        ],
                      ),
                      Divider(),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Overview of the teaching method',
                            style: h4,
                          ),
                          Text(
                            snapshot.data.docs.first.data()['teachingOverview'],
                            style: h5,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        height: 55,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Builder(builder: (context) {
                            return MaterialButton(
                                height: 50,
                                minWidth: 180,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  ' Approve',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: accentYellow,
                                onPressed: () async {
                                  final action = await Dialogs.yesAbortDialog(
                                      context,
                                      'Sure?',
                                      'Are you sure you want to approve this request?');
                                  if (action == DialogAction.yes) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .where('uid', isEqualTo: this.id)
                                        .get()
                                        .then((value) =>
                                            value.docs.forEach((element) {
                                              element.reference.update({
                                                'role': 'tutor',
                                              }).then(
                                                (value) => showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog();
                                                    }),
                                              );
                                            }));

                                    Navigator.pop(context);
                                  } else {
                                    setState(() => null);
                                  }
                                });
                          }),
                          SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                              height: 50,
                              minWidth: 180,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                ' Reject',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: accentOrange,
                              onPressed: () async {
                                final action = await WarningDialogs.yesAbortDialog(
                                    context,
                                    'Sure?',
                                    'Are you sure you want to reject this request?');
                                if (action == DialogAction.yes) {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .where('uid', isEqualTo: this.id)
                                      .get()
                                      .then(
                                        (value) =>
                                            value.docs.forEach((element) {
                                          element.reference.update({
                                            'role': 'learner',
                                          }).then(
                                            (value) =>
                                                (value) => print('Success!'),
                                          );
                                        }),
                                      );
                                  Navigator.pop(context);
                                } else {
                                  setState(() => null);
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class AlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 280,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' You successfully approved the new applicant',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  SizedBox(
                    height: 40,
                    width: 250,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      color: Colors.orangeAccent[400],
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Got it',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            child: CircleAvatar(
              backgroundColor: Colors.orangeAccent[400],
              radius: 50,
              child: Icon(
                Icons.check_outlined,
                size: 50,
                color: Colors.white,
              ),
            ),
            top: -60,
          )
        ],
      ),
    );
  }
}
