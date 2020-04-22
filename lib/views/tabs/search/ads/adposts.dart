import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/models/ads.dart';
import 'package:iconnect/views/tabs/feed/progress.dart';
import 'package:provider/provider.dart';

class AdPosts extends StatelessWidget {
  final List<Ads> ads;
  AdPosts({this.ads});
  @override
  Widget build(BuildContext context) {
    var adsSnapshot = Firestore.instance.collection("advertisements");
    return Consumer<Auth>(builder: (ctx, auth, child) {
      return Container(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              adsSnapshot.orderBy('date', descending: true).snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> adsSnapshot) {
            if (adsSnapshot.hasError) return Container(child: Text('no advertiesment found'),);
            switch (adsSnapshot.connectionState) {
              case ConnectionState.waiting:
                return circularProgress();
              default:
                return ListView(
                  children: adsSnapshot.data.documents.map(
                    (DocumentSnapshot doc) {
                    

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
                                                  doc["picture"],
                                                  
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
                                                    doc["businessName"],
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
                                                        detailPage1,
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
