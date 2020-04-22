import 'package:flutter/material.dart';
import 'package:iconnect/core/services/database.dart';
import 'package:iconnect/core/view_models/feed_model.dart';
import 'package:iconnect/locator.dart';
import 'package:iconnect/models/post.dart';
import 'package:iconnect/models/user.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../home.dart';

class UserPostItem extends StatefulWidget {
  UserPostItem({
    Key key,
    this.post,
  }) : super(key: key);

  final Post post;
  @override
  _UserPostItemState createState() => _UserPostItemState();
}

class _UserPostItemState extends State<UserPostItem> {
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
              child: FutureBuilder(
                future: locator<Database>().getUserInfo(widget.post.userId),
                builder: (ctx, snap) {
                  if (snap.connectionState == ConnectionState.waiting)
                    return Container();
                  else {
                    User user = snap.data;
                    return InkWell(
                      onLongPress: () {
                        HomePage.scaffoldKey.currentState
                            .showBottomSheet((ctx) => Container(
                                  height: 200,
                                  color: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: [myBoxShadow],
                                        color: Color(0xffE0E9E9),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(35),
                                            topRight: Radius.circular(35))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Divider(
                                          thickness: 5,
                                          indent: 120,
                                          endIndent: 120,
                                        ),
                                        Spacer(
                                          flex: 2,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 40,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 50),
                                          child: RaisedButton(
                                            elevation: 5.0,
                                            onPressed: () {
                                              Provider.of<FeedModel>(context,
                                                      listen: false)
                                                  .deletePost(widget.post.id);
                                              Navigator.of(context).pop();
                                            },
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0),
                                            ),
                                            child: Text(
                                              'Delete',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: double.infinity,
                                          height: 40,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 50),
                                          child: RaisedButton(
                                            elevation: 5.0,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0),
                                            ),
                                            child: Text(
                                              'Cancel',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.3),
                                    offset: Offset(0, 2),
                                    blurRadius: 5)
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 23,
                              backgroundImage: NetworkImage(user.photo),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                user.name,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.title,
                              ),
                              if (!user.isAdmin)
                                Text('@${user.username}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400)),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    );
                  }
                },
              )),
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
