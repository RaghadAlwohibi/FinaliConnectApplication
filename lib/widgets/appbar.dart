import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconnect/utils/colors.dart';

AppBar buildSharedAppBar(BuildContext context, String title,
    {Widget action, Widget bottom, Widget leading}) {
  return AppBar(
    actions: [action ?? Container()],
    elevation: 0,
    brightness: Brightness.light,
    backgroundColor: scaffoldBackgroundColor,
    title: Text(
      title,
      style: Theme.of(context).textTheme.title,
    ),
    bottom: PreferredSize(
        child: bottom == null
            ? Container(
                color: appBarBorderColor,
                height: 1.0,
              )
            : bottom,
        preferredSize:
            bottom == null ? Size.fromHeight(4.0) : Size.fromHeight(65.0)),
    centerTitle: true,
    leading: leading == null
        ? Padding(
            child: Image.asset('assets/images/shareicon.png'),
            padding: EdgeInsets.symmetric(horizontal: 10),
          )
        : leading,
  );
}

AppBar buildSharedAppBar2({BuildContext context, List<Widget> actions}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions,
    ),
    elevation: 0,
    brightness: Brightness.light,
    backgroundColor: scaffoldBackgroundColor,
  );
}
