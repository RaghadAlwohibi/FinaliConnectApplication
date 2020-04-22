import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

Widget buidSharedBackButton(context) => IconButton(
      iconSize: 34,
      onPressed: () {
        Navigator.of(context).pop();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      color: Colors.black,
      icon: Icon(Icons.arrow_back),
    );

Widget buildAppbarCancelButton(context) => CupertinoButton(
      child: Text(
        'Cancel',
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
Widget buildAppbarGenericButton(
        {BuildContext context, String title, Function function}) =>
    CupertinoButton(
      child: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700),
      ),
      onPressed: function,
    );
Widget buildAppbarFilterButton(context, Function function) => IconButton(
      iconSize: 34,
      onPressed: function,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      color: Colors.black,
      icon: Icon(
        LineIcons.filter,
        color: Colors.black,
      ),
    );
