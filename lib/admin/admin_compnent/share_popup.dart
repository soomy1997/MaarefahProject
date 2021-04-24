import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class ShareDialog1 extends StatefulWidget {
  @override
  _ShareDialogState createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog1> {
  String msg =
      'hello,there is important session happening now Download Maarefah application ';

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: buildStac());
  }

  Widget buildStac() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 290,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Share this session:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Image(
                        height: 40,
                        width: 40,
                        fit: BoxFit.fitHeight,
                        image: AssetImage('images/twittericon.png'),
                      ),
                      Text('share to twitter'),
                    ],
                  ),
                  onPressed: () async {
                    var response =
                        await FlutterShareMe().shareToTwitter(msg: msg);
                    if (response == 'success') {
                      print('navigate success');
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                MaterialButton(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Image(
                        height: 40,
                        width: 40,
                        fit: BoxFit.fitHeight,
                        image: AssetImage('images/wh.png'),
                      ),
                      Text('share to WhatsApp'),
                    ],
                  ),
                  onPressed: () {
                    FlutterShareMe().shareToWhatsApp(msg: msg);
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                MaterialButton(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Image(
                        height: 40,
                        width: 40,
                        fit: BoxFit.fitHeight,
                        image: AssetImage('images/fa.png'),
                      ),
                      Text('share to Facebook'),
                    ],
                  ),
                  onPressed: () {
                    FlutterShareMe().shareToFacebook(msg: msg);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
