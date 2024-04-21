import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;

Future show_cupertinoDialog(
    {required BuildContext context,
    required Function() on_done,
    required String title,
    required String subtitle,
    required String yes_title,
    required String no_subtitle}) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) => cupertino.CupertinoAlertDialog(
            title: new Text("${title}"),
            content: new Text("${subtitle}"),
            actions: <Widget>[
              if (no_subtitle.isNotEmpty)
                cupertino.CupertinoDialogAction(
                  child: Text("$no_subtitle"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              cupertino.CupertinoDialogAction(
                child: Text("$yes_title"),
                onPressed: () {
                  on_done.call();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}
