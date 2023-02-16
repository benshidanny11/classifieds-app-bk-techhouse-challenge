import 'package:classfiedapp/screens/home.dart';
import 'package:classfiedapp/utils/theme_util.dart';
import 'package:flutter/material.dart';

void showCustomAlertDialog(BuildContext context, String title, String content,
    {Function? onPostiveButtonClick, Function? onNegativeButtonClick}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            onNegativeButtonClick!();
            Navigator.of(ctx).pop();
          },
          child: Text(
            "No",
            style: ThemeUtil().customTextStyle(
                Theme.of(context).primaryColor, 13, FontWeight.w700),
          ),
        ),
        TextButton(
          onPressed: () {
            onPostiveButtonClick!();
            Navigator.of(ctx).pop();
          },
          child: Text(
            "Yes",
            style: ThemeUtil().customTextStyle(
                Theme.of(context).primaryColor, 13, FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}
