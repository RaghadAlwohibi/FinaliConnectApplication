import 'package:flutter/material.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/models/ad_request.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/utils/utils.dart';
import 'package:iconnect/widgets/mycircleavatar.dart.dart';

class AdRequestListItem extends StatefulWidget {
  AdRequestListItem({
    Key key,
    this.adRequest,
  }) : super(key: key);

  final AdRequest adRequest;
  @override
  _AdRequestListItemState createState() => _AdRequestListItemState();
}

class _AdRequestListItemState extends State<AdRequestListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(adminAdsPage, arguments: widget.adRequest);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
            //color: instructorListColor,
            border: Border.all(color: appBarBorderColor, width: 2)),
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            MyCircleAvatar(imgUrl: widget.adRequest.picture),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.adRequest.businessName,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .apply(color: Colors.black)),
                Text(
                  widget.adRequest.category,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
            
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
