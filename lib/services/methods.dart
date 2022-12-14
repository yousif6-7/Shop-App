import 'package:flutter/material.dart';

import '../consts/widgets.dart';

class Methods {
  static navTo({required BuildContext context, required String routeName}) {
    Navigator.pushNamed(context, routeName);
  }

  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function() function,
    required BuildContext context,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: ReusibleText(
              text: title,
            ),
            content: ReusibleText(text: subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    function();

                  },
                  child: ReusibleText(text: 'Ok')),
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Cansel',
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          );
        });
  }

  static Future<void> ErrorDailog({
    required String subtitle,
    required BuildContext context,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: ReusibleText(
              text: "Error",
            ),
            content: ReusibleText(text: subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          );
        });
  }
}
