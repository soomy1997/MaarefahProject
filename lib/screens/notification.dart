import 'package:flutter/material.dart';
import 'package:flutter_app_1/services/MessagingWidget.dart';

import '../utils/constants.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPage createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  Widget messageWidget() => SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                "Sorry :(\nNothing's hewww yet",
                style: h1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60,
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

  Widget notifications() => Column(
//today
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: DataTable(
                  columnSpacing: 20,
                  dataRowHeight: 60,
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
                  rows: notificationList
                      .map(
                        (notifications) => DataRow(
                          cells: [
                            DataCell(
                              Icon(Icons.notifications_none,
                                  color: accentYellow),
                              showEditIcon: false,
                              placeholder: false,
                            ),
                            DataCell(
                              Text(notifications.text),
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
            ),

//yesterday
            Container(
                padding: const EdgeInsets.only(top: 15),
                child: DataTable(
                    columnSpacing: 20,
                    dataRowHeight: 60,
                    dividerThickness: 1,
                    showBottomBorder: false,
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
                          'Yesterday',
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
                    rows: notificationList
                        .map(
                          (notifications) => DataRow(
                            cells: [
                              DataCell(
                                Icon(Icons.notifications_none,
                                    color: accentYellow),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                Text(notifications.text),
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
                        .toList()))
          ]);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar4(
          context,
          title: 'Notifications',
        ),
        body: Container(child: MessagingWidget()));

    /*Container(
          child: notificationList.isEmpty ? messageWidget() : notifications(),
        ));*/
  }
}

class Notificattion {
  String text;

  Notificattion({this.text});
}

var notificationList = <Notificattion>[
  Notificattion(
      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"),
  Notificattion(
      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"),
  Notificattion(
      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"),
];
//change this to the notification reference from the database
