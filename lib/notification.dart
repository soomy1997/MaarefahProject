import 'package:flutter/material.dart';

import 'utils/constants.dart';

void main() {
  runApp(Notification());
}

class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notification',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: NotificationPage(title: 'Notification'),
    );
  }
}

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NotificationPage createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar2(
          context,
          title: 'Notification',
        ),
        body: Container(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.fromLTRB(25, 15, 5, 0),
                title: Text(
                  'Item $index',
                  style: h4,
                ),
                subtitle: Text('xx minutes ago'),
                onTap: () {},
                leading: Icon(
                  Icons.notifications_active,
                  color: accentYellow,
                ),
              );
            },
          ),
        ));
  }
}
