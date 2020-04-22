import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconnect/utils/colors.dart';

class PostBottomPin extends StatelessWidget {
  final double totalHeight;
  final String title;
  final String subtitle;
  final IconData icon;

  PostBottomPin({this.title, this.icon, this.subtitle, this.totalHeight});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: newPostPinColors, borderRadius: BorderRadius.circular(30)),
      height: totalHeight * 0.10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AutoSizeText(
            title,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Row(
            children: <Widget>[
              Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: AutoSizeText(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 12),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Icon(
                    icon,
                    color: fadedTextColor,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
