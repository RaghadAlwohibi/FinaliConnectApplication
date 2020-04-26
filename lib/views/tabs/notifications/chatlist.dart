import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconnect/views/tabs/login/landing.dart';
import 'package:iconnect/widgets/mycircleavatar.dart.dart';

import 'chat.dart';

class MainScreen extends StatefulWidget {
  MainScreen() : super();

  @override
  State createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  void searchCards(String text) {
    setState(() {});
  }

  bool isLoading = false;
  List<Choice> choices = const <Choice>[
    const Choice(title: 'Settings', icon: Icons.settings),
    const Choice(title: 'Log out', icon: Icons.exit_to_app),
  ];
  var user;
  currentUser() async {
    user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  @override
  void initState() {
    super.initState();
    currentUser();
  }

  void onItemMenuPress(Choice choice) {
    if (choice.title == 'Log out') {
      handleSignOut();
    } else {}
  }

  TextEditingController editingController = TextEditingController();

  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();

    this.setState(() {
      isLoading = false;
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LandingPage()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: editingController.text != ""
                ? Firestore.instance
                    .collection('users')
                    .where("name",
                        isGreaterThanOrEqualTo: editingController.text)
                    .snapshots()
                : Firestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                );
              } else {
                return Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        color: Colors.transparent,
                        child: TextField(
                          style: new TextStyle(color: Colors.black),
                          controller: editingController,
                          decoration: InputDecoration(
                              labelText: "Search",
                              hintText: "Search for users...",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)))),
                          onChanged: (editingController) {
                            setState(() {
                              // editingController=editingController;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) =>
                            buildItem(context, snapshot.data.documents[index]),
                        itemCount: snapshot.data.documents.length,
                      ),
                    ),
                  ],
                );
              }
            },
          ),

          // Loading
          Positioned(
            child: isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor)),
                    ),
                    color: Colors.white.withOpacity(0.8),
                  )
                : Container(),
          )
        ],
      ),
      backgroundColor: Colors.grey[30],
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    if (document['id'] == user.uid) {
      return Container();
    } else {
      return Column(
        children: <Widget>[
          Container(
             child: FlatButton(
              child: Row(
                children: <Widget>[
                  Material(
                    child: document['photo'] != null
                        ? MyCircleAvatar(
                            imgUrl: document['photo'],
                          )
                        : Icon(
                            Icons.account_circle,
                            size: 50.0,
                             
                          ),
                  ),
                  Flexible(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              '${document['name']}',
                              style: Theme.of(context).textTheme.subhead.apply(
                    color: Colors.black
                  ),
                            ),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                          ),
                          Container(
                            child: Text(
                              '@${document['username']}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(left: 20.0),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Chat(
                              peerId: document['id'],
                              peerAvatar: document['photo'],
                              peerName: document['name'],
                              peerUsername: document['username'],
                            )));
              },
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0),
            ),
          ),
          Divider(),
        ],
      );
    }
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
