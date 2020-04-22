import 'package:flutter/material.dart';
import 'package:iconnect/utils/colors.dart';

class HeaderPill extends StatelessWidget {
  final String title;
  final Function onClick;
  HeaderPill({this.title, this.onClick});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 30,
        width: 90,
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle,
        ),
        decoration: BoxDecoration(
            color: lostItemPinColor, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
