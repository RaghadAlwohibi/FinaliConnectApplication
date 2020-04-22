import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/locator.dart';
import 'package:iconnect/models/event.dart';
import 'package:iconnect/views/tabs/feed/progress.dart';
import 'package:iconnect/views/tabs/search/events/eventitem.dart';
import 'package:iconnect/views/tabs/feed/comments.dart';
import 'package:provider/provider.dart';

import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:time_formatter/time_formatter.dart';

class EvPosts extends StatelessWidget {
  final List<Event> events;
  EvPosts({this.events});
  @override
  Widget build(BuildContext context) {
    var postsSnapshot = Firestore.instance.collection("posts");
    var usersSnapshot = Firestore.instance.collection("users").snapshots();
    var totalWidth = MediaQuery.of(context).size.width;
    var totathg = MediaQuery.of(context).size.height;

    return Consumer<Auth>(builder: (ctx, auth, child) {
      return Container(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              postsSnapshot.orderBy('createdAt', descending: true).snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> postsSnapshot) {
            if (postsSnapshot.hasError) return circularProgress();
            switch (postsSnapshot.connectionState) {
              case ConnectionState.waiting:
                return circularProgress();
              default:
                return ListView(
                  children: postsSnapshot.data.documents.map(
                    (DocumentSnapshot doc) {
                      List<dynamic> list = List.from(doc['likes']);

                      if (doc['type'] == 4) {
                        _color() {
                          List<dynamic> list = List.from(doc['likes']);
                          if (list.contains(auth.currentUser.id)) {
                            return Colors.red;
                          } else {
                            return Colors.black;
                          }
                        }

                        var height2 = MediaQuery.of(context).size.height / 2.7;
                        return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.transparent, width: 1),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Container(
                              height: height2,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 3.0,
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(33), //
                                            topRight: Radius.circular(
                                                33) // //                <--- border radius here
                                            ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              
                                                image: new NetworkImage(
                                                  doc["imageUrl"],
                                                  
                                                ),
                                                
                                                fit: BoxFit.fitWidth),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25.0),
                                                topRight:
                                                    Radius.circular(25.0))),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    doc["title"],
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: InkWell(
                                                      onTap: () =>
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                        evdetailPage,
                                                        arguments:
                                                            doc,
                                                      ),
                                                      child: Text(
                                                        "Show more >",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors
                                                                .teal[800]),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ));
                      } else {
                        return Container(child: Text('no events found'),);
                      }
                    },
                  ).toList(),
                );
            }
          },
        ),
      );
    });
  }
}
