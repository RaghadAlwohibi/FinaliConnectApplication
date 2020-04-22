import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/core/view_models/feed_model.dart';
import 'package:iconnect/locator.dart';
import 'package:iconnect/models/post.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/feed/progress.dart';
import 'package:iconnect/views/tabs/profile/user_post_item.dart';
import 'package:provider/provider.dart';

import 'package:provider_architecture/viewmodel_provider.dart';

import '../../home.dart';

class UserPosts extends StatelessWidget {
  final List<Post> posts;
  UserPosts({this.posts});
  var postsSnapshot = Firestore.instance.collection("posts");
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, child) {
        return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("posts").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return circularProgress();
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return circularProgress();
              default:
                return ListView(
                  children: snapshot.data.documents.map(
                    (DocumentSnapshot doc) {
                      if (doc["creator"] == auth.currentUser.id) {
                        return InkWell(
                           onTap: () {
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
                                                  Firestore.instance
                                                      .collection("posts")
                                                      .document(doc["id"])
                                                      .delete();
                                                  Navigator.of(context).pop();
                                                },
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                shape:
                                                    new RoundedRectangleBorder(
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
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                shape:
                                                    new RoundedRectangleBorder(
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
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 8.0, bottom: 10.0),
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
                                      backgroundImage:
                                          NetworkImage(auth.currentUser.photo),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        auth.currentUser.name,
                                        textAlign: TextAlign.left,
                                        style:
                                            Theme.of(context).textTheme.title,
                                      ),
                                      if (!auth.currentUser.isAdmin)
                                        Text('@${auth.currentUser.username}',
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
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 18.0),
                                  child: Container(
                                    child: Text(
                                      doc["body"],
                                      style: Theme.of(context).textTheme.body1,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ).toList(),
                );
            }
          },
        );
      },
    );
  }
}
