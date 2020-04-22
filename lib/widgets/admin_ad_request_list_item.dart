import 'package:flutter/material.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/models/ad_request.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/utils/utils.dart';

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
            color: instructorListColor,
            border: Border.all(color: appBarBorderColor, width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                boxShadow: [myBoxShadow],
                color: Colors.white,
                image: DecorationImage(
                  image: widget.adRequest.picture == null
                      ? AssetImage(AvailableImages.adsImage)
                      : NetworkImage(widget.adRequest.picture),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.adRequest.category,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
