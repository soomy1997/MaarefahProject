import 'package:flutter/material.dart';

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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar4(
          context,
          title: 'Notifications',
        ),
        body: Container(child: Text('data')
            //  MessagingWidget()
            ));

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
