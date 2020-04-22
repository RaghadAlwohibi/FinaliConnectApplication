import 'package:flutter/material.dart';
import 'package:iconnect/models/post.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/utils/utils.dart';

class GenericPost extends StatefulWidget {
  GenericPost({
    Key key,
    this.post,
  }) : super(key: key);

  final Post post;
  @override
  _GenericPostState createState() => _GenericPostState();
}

class _GenericPostState extends State<GenericPost> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var totalHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(20),
      height: totalHeight * 0.20,
      decoration: BoxDecoration(
          color: instructorListColor,
          border: Border.all(color: appBarBorderColor, width: 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          boxShadow: [myBoxShadow],
                          image: DecorationImage(
                            image: AssetImage(AvailableImages.instructorImage),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'name',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      '@username',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  'date',
                  //widget.post.createdAt,
                  style: Theme.of(context).textTheme.subtitle,
                )
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Text(
              widget.post.body,
              style: Theme.of(context).textTheme.body1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
