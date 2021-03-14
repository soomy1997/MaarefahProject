import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';

class NoIntentConnection extends StatefulWidget {
  @override
  _NoIntentConnectionState createState() => _NoIntentConnectionState();
}

class _NoIntentConnectionState extends State<NoIntentConnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar1(
        context,
        title: 'System Message',
        iconButton: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {},
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "No Internet Connection",
                  style: h1,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Please check your internet connection \nand try again",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                Image(
                  image: AssetImage("images/client.jpg"),
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width * 0.99,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
