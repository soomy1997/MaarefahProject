import 'package:flutter/material.dart';

class AlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        clipBehavior: Clip.none, alignment: Alignment.topCenter,
        children: [
          Container(
            height: 260,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You successfuly registered the session',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  SizedBox(
                    height: 40,
                    width: 250,
                    child: MaterialButton(
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