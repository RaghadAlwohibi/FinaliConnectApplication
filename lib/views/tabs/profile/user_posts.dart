import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/models/post.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/feed/progress.dart';
import 'package:iconnect/views/tabs/notifications/fullPhoto.dart';
import 'package:provider/provider.dart';
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
          stream: Firestore.instance.collection("posts").orderBy('createdAt', descending: true).snapshots(),
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
                          onTap: () {},
                          child: Container(
                            color: Color(0xFFe4edec),
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
                                              color:
                                                  Colors.grey.withOpacity(.3),
                                              offset: Offset(0, 2),
                                              blurRadius: 5)
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 23,
                                        backgroundImage: NetworkImage(
                                            auth.currentUser.photo),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                    IconButton(
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          HomePage.scaffoldKey.currentState
                                              .showBottomSheet((ctx) =>
                                                  Container(
                                                    height: 200,
                                                    color: Colors.transparent,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 10),
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            myBoxShadow
                                                          ],
                                                          color:
                                                              Color(0xffE0E9E9),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          35),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          35))),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
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
                                                            width:
                                                                double.infinity,
                                                            height: 40,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        50),
                                                            child: RaisedButton(
                                                              elevation: 5.0,
                                                              onPressed: () {
                                                                Firestore
                                                                    .instance
                                                                    .collection(
                                                                        "posts")
                                                                    .document(
                                                                        doc["id"])
                                                                    .delete();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              shape:
                                                                  new RoundedRectangleBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        30.0),
                                                              ),
                                                              child: Text(
                                                                'Delete',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .button
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18),
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: 40,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        50),
                                                            child: RaisedButton(
                                                              elevation: 5.0,
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              shape:
                                                                  new RoundedRectangleBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        30.0),
                                                              ),
                                                              child: Text(
                                                                'Cancel',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .button
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18),
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                        })
                                  ],
                                ),
                                Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 18.0),
                                    child: Container(
                                      child: Text(
                                        doc["body"],
                                        style:
                                            Theme.of(context).textTheme.body1,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                if (doc['imageUrl'] != null)
                                FlatButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FullPhoto(
                                                                url: doc[
                                                                    "imageUrl"])));
                                              },
                                              child: Image.network(
                                                doc["imageUrl"],
                                                fit: BoxFit.cover,
                                                width: 380.0,
                                                height: 335,
                                              ),
                                            ),
                                Divider(),
                              ],
                            ),
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
