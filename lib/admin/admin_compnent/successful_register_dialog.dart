import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';

class AlertDialog1 extends StatefulWidget {
  @override
  _AlertDialogState createState() => _AlertDialogState();
}

class _AlertDialogState extends State<AlertDialog1> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: buildStac());
  }

  Widget buildStac() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: Column(
              children: [
                Text(
                  'You successfuly registered \nthe session',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: MaterialButton(
                    color: accentYellow,
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
      ],
    );
  }
}
