import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/models/message.dart';
import 'package:flutter_app_1/utils/constants.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  Widget messageWidget() => SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                "Sorry 🙁\nNothing's here yet",
                style: h1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Image(
                image: AssetImage("images/pic1.png"),
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.99,
              ),
            ],
          ),
        ),
      );

  Widget notifs() => Container(
        padding: const EdgeInsets.only(top: 15),
        child: DataTable(
            columnSpacing: 20,
            dataRowHeight: 70,
            dividerThickness: 1,
            showBottomBorder: true,
            columns: <DataColumn>[
              DataColumn(
                label: Text(
                  ' ',
                  style: h4,
                ),
                numeric: false,
              ),
              DataColumn(
                label: Text(
                  'Today',
                  style: h4,
                ),
                numeric: false,
              ),
              DataColumn(
                label: Text(
                  ' ',
                ),
                numeric: false,
              )
            ],
            rows: messages
                .map(
                  (buildMessage) => DataRow(
                    cells: [
                      DataCell(
                        Icon(Icons.notifications_none, color: accentYellow),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0)),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                buildMessage.title,
                                style: h4.copyWith(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              buildMessage.body +
                                  '                                                                         ',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 13),
                              softWrap: true,
                            ),
                          ],
                        ),
                        showEditIcon: false,
                        placeholder: true,
                      ),
                      DataCell(
                        Icon(Icons.close, color: accentOrange),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                    ],
                  ),
                )
                .toList()),
      );

  int notificationCounter = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      final notification = message['notification'];

      setState(() {
        messages.add(
            Message(title: notification['title'], body: notification['body']));
        notificationCounter++;
      });
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");

      final notification = message['data'];
      setState(() {
        messages.add(Message(
          title: '${notification['title']}',
          body: '${notification['body']}',
        ));
        notificationCounter++;
      });
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      notificationCounter++;
    });
  }

  @override
  Widget build(BuildContext context) =>
      notificationCounter == 0 ? messageWidget() : notifs();

  Widget buildMessage(Message message) => ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
      );
}
