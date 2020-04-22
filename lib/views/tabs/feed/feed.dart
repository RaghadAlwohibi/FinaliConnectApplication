import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/feed/progress.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/widgets/appbar.dart';
import 'package:iconnect/views/tabs/feed/comments.dart';
import 'package:iconnect/widgets/custom_toggle2.dart';
import 'package:iconnect/widgets/mycircleavatar.dart.dart';
import 'package:time_formatter/time_formatter.dart';
import 'package:provider/provider.dart';

final DateTime timestamps = DateTime.now();
final userRef = Firestore.instance.collection('users');

class FeedsPage extends StatefulWidget {
  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  @override
  PageController _pageController;
  Color _color = Colors.white;
  Color _color2 = Colors.white;
  Color _color3 = Colors.white;
  var color4 = Colors.white;
  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var postsSnapshot = Firestore.instance.collection("posts");
    var usersSnapshot = Firestore.instance.collection("users").snapshots();
    var totlaHeigt = MediaQuery.of(context).size.height;
    var totalWidth = MediaQuery.of(context).size.width;
    void navigatorToPage(int index) {
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }

    return Consumer<Auth>(
      builder: (ctx, auth, child) {
        return Scaffold(
          appBar: buildSharedAppBar(
            context,
            'Home',
            
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //here were i start
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                margin: EdgeInsets.all(5.0),
                width: totalWidth,
                // height: totlaHeigt / 4,
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('advertisements')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return circularProgress();
                    return CarouselSlider.builder(
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      autoPlay: true,
                      enlargeCenterPage: true,

                      // reverse: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        List rev = snapshot.data.documents;
                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              child: Image.network(
                                rev[index].data["picture"],
                                fit: BoxFit.cover,
                                width: 1000.0,
                                height: totlaHeigt / 2,
                              ),
                            ),
                          ),
                          onTap: () => Navigator.of(context).pushNamed(
                            detailPage,
                            arguments: rev[index].data,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
// To do on tap navigate to the page detail ....

              Postn(
                postsSnapshot: postsSnapshot,
                usersSnapshot: usersSnapshot,
                totalWidth: totalWidth,
                totalh: totlaHeigt,
                auth: auth,
              )
            ],
          ),
        );
      },
    );
  }
}

class Postn extends StatefulWidget {
  var auth;

  var totalh;

  Postn({
    Key key,
    @required this.postsSnapshot,
    @required this.usersSnapshot,
    @required this.totalWidth,
    @required this.totalh,
    @required this.auth,
  }) : super(key: key);

  final CollectionReference postsSnapshot;
  final Stream<QuerySnapshot> usersSnapshot;
  final double totalWidth;

  @override
  _PostnState createState() => _PostnState();
}

class _PostnState extends State<Postn> {
  var color4 = Colors.white;
  var color5 = Colors.white;
  var color6 = Colors.white;
  var color7 = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: widget.postsSnapshot
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> postsSnapshot) {
            return StreamBuilder(
              stream: widget.usersSnapshot,
              builder: (context, usersSnapshot) {
                if (postsSnapshot.hasError ||
                    usersSnapshot.hasError ||
                    !usersSnapshot.hasData) return circularProgress();
                switch (postsSnapshot.connectionState) {
                  case ConnectionState.waiting:
                    return circularProgress();
                  default:
                    return ListView(
                      children: postsSnapshot.data.documents.map(
                        (DocumentSnapshot doc) {
                          var user;
                          List<dynamic> list = List.from(doc['likes']);
                          if (doc['creator'] != null &&
                              usersSnapshot.data != null &&
                              doc['type'] == 0) {
                            user = doc['creator'];

                            user = usersSnapshot.data.documents.firstWhere(
                                (userDoc) => userDoc.documentID == user);
                          } else if (doc['creator'] != null &&
                              usersSnapshot.data != null &&
                              doc['type'] == 1) {
                            user = doc['creator'];
                            user = usersSnapshot.data.documents.firstWhere(
                                (userDoc) => userDoc.documentID == user);
                          }
                          //-----------------------lost item =0 ------------------------------------
                          if (doc['type'] == 0) {
                            _color() {
                              List<dynamic> list = List.from(doc['likes']);
                              if (list.contains(widget.auth.currentUser.id)) {
                                return Colors.red;
                              } else {
                                return Colors.black;
                              }
                            }

                            return Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: <Widget>[
                                          user.data["isAdmin"] == false
                                              ? Container(
                                                  child: MyCircleAvatar(
                                                    imgUrl: user.data['photo'],
                                                  ),
                                                )
                                              : Container(),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    user.data["isAdmin"] ==
                                                            false
                                                        ? user.data["name"]
                                                        : "",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    user.data["isAdmin"] ==
                                                            false
                                                        ? "@" +
                                                            user.data[
                                                                "username"]
                                                        : "",
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  height: 300,
                                  width: widget.totalWidth,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          child: Image.network(
                                            doc["imageUrl"],
                                            fit: BoxFit.cover,
                                            width: 380.0,
                                            height: 335,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: EdgeInsets.only(left: 60),
                                      child: Text(doc["title"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 60),
                                    child: Text(
                                      "Location : found at " + doc["location"],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        formatTime(doc["createdAt"]),
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Comments(
                                                        postid: doc["id"],
                                                        cret: doc["creator"]
                                                        //   pimageUrl:  doc["imageUrl"],
                                                        )),
                                              );
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.comment,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print(widget.auth.currentUser.id);
                                              List<dynamic> list =
                                                  List.from(doc['likes']);
                                              if (!list.contains(
                                                  widget.auth.currentUser.id)) {
                                                list.add(
                                                    widget.auth.currentUser.id);
                                                Firestore.instance
                                                    .collection("posts")
                                                    .document(doc["id"])
                                                    .updateData(
                                                        {"likes": list});
                                                Firestore.instance
                                                    .collection("Notifications")
                                                    .document(user.data["id"])
                                                    .collection("Notifications")
                                                    .document()
                                                    .setData({
                                                  "name": widget
                                                      .auth.currentUser.name,
                                                  "message": "Liked you post",
                                                  "time": timestamps,
                                                  "avatarUrl": widget
                                                      .auth.currentUser.photo
                                                });
                                                //setState(() {});
                                              } else {
                                                var b = list.remove(
                                                    widget.auth.currentUser.id);
                                                if (b) {
                                                  Firestore.instance
                                                      .collection("posts")
                                                      .document(doc["id"])
                                                      .updateData(
                                                          {"likes": list});
                                                  //setState(() {});
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
                                                      (list.length).toString() +
                                                          ' likes',
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          }
                          //-----------------------normal item =1 ------------------------------------
                          else if (doc['type'] == 1 &&
                              doc['imageUrl'] == null &&
                              user.data['isAdmin'] == false) {
                            _color() {
                              List<dynamic> list = List.from(doc['likes']);

                              if (list.contains(widget.auth.currentUser.id)) {
                                return Colors.red;
                              } else {
                                return Colors.grey;
                              }
                            }

                            return Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: MyCircleAvatar(
                                              imgUrl: user.data['photo'],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    user.data["name"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "@" + user.data["username"],
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 60,
                                          top: 10,
                                          bottom: 10,
                                          right: 10),
                                      child: Text(doc['body'])),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        formatTime(doc["createdAt"]),
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Comments(
                                                      postid: doc["id"],
                                                      cret: doc["creator"]
                                                      //   pimageUrl: doc["imageUrl"],
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Icon(Icons.comment),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print(widget.auth.currentUser.id);
                                              List<dynamic> list =
                                                  List.from(doc['likes']);
                                              if (!list.contains(
                                                  widget.auth.currentUser.id)) {
                                                list.add(
                                                    widget.auth.currentUser.id);
                                                Firestore.instance
                                                    .collection("posts")
                                                    .document(doc["id"])
                                                    .updateData(
                                                        {"likes": list});
                                                Firestore.instance
                                                    .collection("Notifications")
                                                    .document(user.data["id"])
                                                    .collection("Notifications")
                                                    .document()
                                                    .setData({
                                                  "name": widget
                                                      .auth.currentUser.name,
                                                  "message": "Liked you post",
                                                  "time": timestamps,
                                                  "avatarUrl": widget
                                                      .auth.currentUser.photo
                                                });
                                                //setState(() {});
                                              } else {
                                                var b = list.remove(
                                                    widget.auth.currentUser.id);
                                                if (b) {
                                                  Firestore.instance
                                                      .collection("posts")
                                                      .document(doc["id"])
                                                      .updateData(
                                                          {"likes": list});
                                                  //setState(() {});
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
                                                      (list.length).toString() +
                                                          ' likes',
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          } else if (doc['type'] == 1 &&
                              doc['imageUrl'] != null &&
                              user.data['isAdmin'] == false) {
                            _color() {
                              List<dynamic> list = List.from(doc['likes']);

                              if (list.contains(widget.auth.currentUser.id)) {
                                return Colors.red;
                              } else {
                                return Colors.black;
                              }
                            }

                            return Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: MyCircleAvatar(
                                              imgUrl: user.data['photo'],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    user.data["name"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "@" + user.data["username"],
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  height: 300,
                                  width: widget.totalWidth,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          child: Image.network(
                                            doc["imageUrl"],
                                            fit: BoxFit.cover,
                                            width: 380.0,
                                            height: 335,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 60,
                                          top: 10,
                                          bottom: 10,
                                          right: 10),
                                      child: Text(doc['body'])),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        formatTime(doc["createdAt"]),
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Comments(
                                                      postid: doc["id"],
                                                      cret: doc["creator"]
                                                      //   pimageUrl: doc["imageUrl"],
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Icon(Icons.comment),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print(widget.auth.currentUser.id);
                                              List<dynamic> list =
                                                  List.from(doc['likes']);
                                              if (!list.contains(
                                                  widget.auth.currentUser.id)) {
                                                list.add(
                                                    widget.auth.currentUser.id);
                                                Firestore.instance
                                                    .collection("posts")
                                                    .document(doc["id"])
                                                    .updateData(
                                                        {"likes": list});
                                                Firestore.instance
                                                    .collection("Notifications")
                                                    .document(user.data["id"])
                                                    .collection("Notifications")
                                                    .document()
                                                    .setData({
                                                  "name": widget
                                                      .auth.currentUser.name,
                                                  "message": "Liked you post",
                                                  "time": timestamps,
                                                  "avatarUrl": widget
                                                      .auth.currentUser.photo
                                                });
                                                //setState(() {});
                                              } else {
                                                var b = list.remove(
                                                    widget.auth.currentUser.id);
                                                if (b) {
                                                  Firestore.instance
                                                      .collection("posts")
                                                      .document(doc["id"])
                                                      .updateData(
                                                          {"likes": list});

                                                  //setState(() {});
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
                                                      (list.length).toString() +
                                                          ' likes',
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          }
                          //announcement
                          else if (doc['type'] == 1 &&
                              doc['imageUrl'] == null &&
                              user.data['isAdmin'] == true) {
                            _color() {
                              List<dynamic> list = List.from(doc['likes']);

                              if (list.contains(widget.auth.currentUser.id)) {
                                return Colors.red;
                              } else {
                                return Colors.black;
                              }
                            }

                            return Container(
                              color: Colors.red[100],
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 60,
                                            top: 10,
                                            bottom: 10,
                                            right: 10),
                                        child: Text(doc['body'])),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          formatTime(doc["createdAt"]),
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Comments(
                                                      postid: doc["id"],
                                                      //   pimageUrl: doc["imageUrl"],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Icon(Icons.comment),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                List<dynamic> list =
                                                    List.from(doc['likes']);
                                                if (!list.contains(widget
                                                    .auth.currentUser.id)) {
                                                  list.add(widget
                                                      .auth.currentUser.id);
                                                  Firestore.instance
                                                      .collection("posts")
                                                      .document(doc["id"])
                                                      .updateData(
                                                          {"likes": list});
                                                  //setState(() {});
                                                } else {
                                                  var b = list.remove(widget
                                                      .auth.currentUser.id);
                                                  if (b) {
                                                    Firestore.instance
                                                        .collection("posts")
                                                        .document(doc["id"])
                                                        .updateData(
                                                            {"likes": list});
                                                    //setState(() {});
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
                                                        (list.length)
                                                                .toString() +
                                                            ' likes',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          } else if (doc['type'] == 1 &&
                              doc['imageUrl'] != null &&
                              user.data['isAdmin'] == true) {
                            _color() {
                              List<dynamic> list = List.from(doc['likes']);

                              if (list.contains(widget.auth.currentUser.id)) {
                                return Colors.red;
                              } else {
                                return Colors.black;
                              }
                            }

                            return Container(
                              color: Colors.red[100],
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    // padding:
                                    //     EdgeInsets.only(top: 10, bottom: 10),
                                    height: 300,
                                    width: widget.totalWidth,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                            child: Image.network(
                                              doc["imageUrl"],
                                              fit: BoxFit.cover,
                                              width: 380.0,
                                              height: 335,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 60,
                                            top: 10,
                                            bottom: 10,
                                            right: 10),
                                        child: Text(doc['body'])),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          formatTime(doc["createdAt"]),
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Comments(
                                                      postid: doc["id"],
                                                      //   pimageUrl: doc["imageUrl"],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Icon(Icons.comment),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                List<dynamic> list =
                                                    List.from(doc['likes']);
                                                if (!list.contains(widget
                                                    .auth.currentUser.id)) {
                                                  list.add(widget
                                                      .auth.currentUser.id);
                                                  Firestore.instance
                                                      .collection("posts")
                                                      .document(doc["id"])
                                                      .updateData(
                                                          {"likes": list});
                                                  //setState(() {});
                                                } else {
                                                  var b = list.remove(widget
                                                      .auth.currentUser.id);
                                                  if (b) {
                                                    Firestore.instance
                                                        .collection("posts")
                                                        .document(doc["id"])
                                                        .updateData(
                                                            {"likes": list});
                                                    //setState(() {});
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
                                                        (list.length)
                                                                .toString() +
                                                            ' likes',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          } else if (doc['type'] == 4 &&
                              doc['imageUrl'] != null) {
                            _color() {
                              List<dynamic> list = List.from(doc['likes']);

                              if (list.contains(widget.auth.currentUser.id)) {
                                return Colors.red;
                              } else {
                                return Colors.black;
                              }
                            }

                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    height: 300,
                                    width: widget.totalWidth,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                            child: Image.network(
                                              doc["imageUrl"],
                                              fit: BoxFit.cover,
                                              width: 380.0,
                                              height: 335,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 60,
                                            top: 10,
                                            bottom: 10,
                                            right: 10),
                                        child: Text(doc['body'])),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 60,
                                            top: 10,
                                            bottom: 10,
                                            right: 10),
                                        child: Text(doc['location'])),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          formatTime(doc["createdAt"]),
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Comments(
                                                      postid: doc["id"],
                                                      //   pimageUrl: doc["imageUrl"],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Icon(Icons.comment),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                List<dynamic> list =
                                                    List.from(doc['likes']);
                                                if (!list.contains(widget
                                                    .auth.currentUser.id)) {
                                                  list.add(widget
                                                      .auth.currentUser.id);
                                                  Firestore.instance
                                                      .collection("posts")
                                                      .document(doc["id"])
                                                      .updateData(
                                                          {"likes": list});
                                                  //setState(() {});
                                                } else {
                                                  var b = list.remove(widget
                                                      .auth.currentUser.id);
                                                  if (b) {
                                                    Firestore.instance
                                                        .collection("posts")
                                                        .document(doc["id"])
                                                        .updateData(
                                                            {"likes": list});
                                                    //setState(() {});
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
                                                        (list.length)
                                                                .toString() +
                                                            ' likes',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          } else
                            return Container(child: Text('no feeds'),);
                        },
                      ).toList(),
                    );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
