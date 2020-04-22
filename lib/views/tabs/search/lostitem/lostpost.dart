import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconnect/models/post.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/feed/progress.dart';
import 'package:iconnect/views/tabs/feed/comments.dart';

import 'package:time_formatter/time_formatter.dart';

import '../../../home.dart';

class LostPosts extends StatefulWidget {
  final List<Post> posts;
  var auth;
  LostPosts({this.posts, this.auth});

  @override
  _LostPostsState createState() => _LostPostsState();
}

class _LostPostsState extends State<LostPosts> {
  var usersSnapshot = Firestore.instance.collection("users").snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;
    var totalHeight = MediaQuery.of(context).size.height;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<QuerySnapshot>(
         stream: Firestore.instance.collection("posts").orderBy('createdAt', descending: true)
              .snapshots(),
        builder: (context, doc) {
          return StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                if (doc.hasError || snapshot.hasError || !snapshot.hasData)
                  return circularProgress();
                switch (doc.connectionState) {
                  case ConnectionState.waiting:
                    return circularProgress();
                  default:
                    return ListView(
                        children: doc.data.documents.map(
                      (DocumentSnapshot doc) {
                        List<dynamic> list = List.from(doc['likes']);
                        var user;
                        if (doc['creator'] != null &&
                            snapshot.data != null &&
                            doc['type'] == 0) {
                          user = doc['creator'];
                          user = snapshot.data.documents.firstWhere(
                              (userDoc) => userDoc.documentID == user);
                        }

                        if (doc['type'] == 0) {
                          _color() {
                            List<dynamic> list = List.from(doc['likes']);

                            if (list.contains(widget.auth.currentUser.id)) {
                              return Colors.red;
                            } else {
                              return Colors.black;
                            }
                          }

                          return Container(
                            padding: EdgeInsets.all(20),
                            height: totalHeight * 0.75,
                            decoration: BoxDecoration(
                             // color: scaffoldBackgroundColor,
                              border: Border.all(
                                  color: appBarBorderColor, width: 2),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: 8.0, bottom: 10.0),
                                      height: 50.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                        boxShadow: [myBoxShadow],
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(user.data["photo"]),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          user.data["name"],
                                          textAlign: TextAlign.left,
                                          style:
                                              Theme.of(context).textTheme.title,
                                        ),
                                        if (!user.data["isAdmin"])
                                          Text(
                                            '@${user.data["username"]}',
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle,
                                          ),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 8,
                                  child: Image.network(
                                    doc["imageUrl"],

                                    fit: BoxFit.cover,
                                    //height: 400,
                                    width: double.infinity,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        List<dynamic> list =
                                            List.from(doc["likes"]);
                                        if (!list.contains(
                                            widget.auth.currentUser.id)) {
                                          list.add(widget.auth.currentUser.id);
                                          Firestore.instance
                                              .collection("posts")
                                              .document(doc["id"])
                                              .updateData({"likes": list});
                                        } else {
                                          var b = list.remove(
                                              widget.auth.currentUser.id);
                                          if (b) {
                                            Firestore.instance
                                                .collection("posts")
                                                .document(doc["id"])
                                                .updateData({"likes": list});
                                          }
                                        }
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.favorite_border,
                                            color: _color(),
                                          ),
                                          Center(
                                          
                                              
                                              child: Center(
                                                child: Text(
                                                  (list.length).toString()+ ' likes',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                          
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      // onTap: () => showComments(
                                      //   context,
                                      //   id: doc["id"],
                                      //   //   imageUrl:widget.post.imageUrl,
                                      // ),
                                      child: Icon(
                                        (Icons.chat),
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      doc["title"],
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context).textTheme.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      doc["location"],
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context).textTheme.body1,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Divider(),
                                Flexible(
                                  fit: FlexFit.loose,
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      doc["body"],
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context).textTheme.body1,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      fit: FlexFit.loose,
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Time: ${formatTime(doc["createdAt"])}',
                                          textAlign: TextAlign.left,
                                          style:
                                              Theme.of(context).textTheme.body1,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(child: Text('no lost item post'),);
                        }
                      },
                    ).toList());
                }
              });
        },
      ),
    );
  }
}
