import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_1/utils/constants.dart';

class ManageSessions extends StatefulWidget {
  @override
  _ManageSessions createState() => _ManageSessions();
}

class _ManageSessions extends State<ManageSessions> {
  Widget build(BuildContext context) {
    final requistButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xffF9A21B),
        child: MaterialButton(
          disabledColor: Colors.grey,
          onPressed: () {},
          child: Text("Add Now",
              textAlign: TextAlign.center, style: yellowButtonsTextStyle),
        ));
    Widget table() {
      return SingleChildScrollView(
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(25),
            1: FlexColumnWidth(30),
            2: FlexColumnWidth(30),
            3: FlexColumnWidth(25),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border(
                        bottom: BorderSide(
                            width: 1.0, color: Colors.grey.shade300))),
                children: [
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(15),
                      child: Text('Session ID', style: h4)),
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(15),
                      child: Text('Session Name', style: h4)),
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(15),
                      child: Text('Tutor Name', style: h4)),
                  Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'options',
                      style: h4,
                    ),
                  )
                ]),
            TableRow(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1.0, color: Colors.grey.shade300))),
                children: [
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        '213362',
                      )),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Lorem ipsum dolor sit amet',
                      )),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Lorem ipsum ',
                      )),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: TextButton(
                      child: Text('More', style: TextStyle(fontSize: 17)),
                      onPressed: () {},
                    ),
                  ),
                ]),
          ],
        ),
      );
    }

    Widget messageWidget() => SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Sorry :(\nNothing's here yet",
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

    return Scaffold(
        appBar: myAppBar1(
          context,
          title: 'Edit Session Details',
          iconButton: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: table(),
        ));
  }
}

class Sessions {
  String text;

  Sessions({this.text});
}

var sessionsDetails = <Sessions>[
  Sessions(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"),
  Sessions(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"),
  Sessions(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"),
];
