import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/widgets/mycircleavatar.dart.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivityScreen extends StatefulWidget {
  @override
  ActivityScreenState createState() {
    return new ActivityScreenState();
  }
}

class ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (ctx, auth, child) {
      return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("notifications")
              .document(auth.currentUser.id)
              .collection("notifications")
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return CircularProgressIndicator();
            } else if (snapshot.data.documents.length == 0) {
              return Column(
               
                children: <Widget>[
                   SizedBox(
                    height: 200.0,
                  ),
                  Text("No Notifications",
              textAlign: TextAlign.center,
              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 17.0,
                                                color: Colors.grey)),
                ],
              );
            } else if (snapshot.data.documents.length != 0) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  return ListView(
                      children:
                          snapshot.data.documents.map((DocumentSnapshot doc) {
                    return Column(
                      children: <Widget>[
                        new Divider(
                          height: 0.0,
                        ),
                        new ListTile(
                          leading: MyCircleAvatar(
                            imgUrl: doc["avatarUrl"],
                          ),
                          title: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text(
                                doc["name"],
                               style: Theme.of(context).textTheme.subhead.apply(
                    color: Colors.black
                  ),
                              ),
                              new Text(
                                timeago.format(doc["time"].toDate()),
                                style: new TextStyle(
                                    color: Colors.grey, fontSize: 12.0),
                              ),
                            ],
                          ),
                          subtitle: new Container(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: new Text(
                              doc["message"],
                              style: new TextStyle(
                                  color: Colors.grey, fontSize: 15.0),
                            ),
                          ),
                        )
                      ],
                    );
                  }).toList());
              }
            }
          });
    });
  }
}
