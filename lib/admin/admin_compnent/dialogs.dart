import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';

enum DialogAction { yes, abort }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            title,
            style: TextStyle(
              color: accentYellow,
            ),
          ),
          content: Text(body, textAlign: TextAlign.left),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(DialogAction.abort),
                    child: const Text(
                      'No',
                      textAlign: TextAlign.end,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(DialogAction.yes),
                    child: const Text(
                      'Yes',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: whiteBG,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}

class WarningDialogs {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            title,
            style: TextStyle(
              color: accentOrange,
            ),
          ),
          content: Text(body, textAlign: TextAlign.left),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(DialogAction.abort),
                    child: const Text(
                      'No',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: accentOrange),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(DialogAction.yes),
                    child: const Text(
                      'Yes',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: whiteBG),
                    ),
                    style: ElevatedButton.styleFrom(primary: accentOrange),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}
