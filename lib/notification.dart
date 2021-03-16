import 'package:flutter/material.dart';

import 'utils/constants.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPage createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  Widget bodyData() => DataTable(
      columnSpacing: 30,
      dataRowHeight: 60,
      dividerThickness: 1,
      showBottomBorder: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            ' ',
          ),
          numeric: false,
        ),
        DataColumn(
          label: Text(
            'Notification',
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
                  Icon(Icons.notifications_active, color: accentYellow),
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
          .toList());
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar2(
          context,
          title: 'Notification',
        ),
        body: Container(
          child: bodyData(),
        ));
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