import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/feed/progress.dart';
import 'package:iconnect/widgets/mycircleavatar.dart.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

final commentRef = Firestore.instance.collection('comments');
final DateTime timestamps = DateTime.now();

var auth1;
var postid1;

class Comments extends StatefulWidget {
  final String postid;
// final String pimageUrl;
  final String cret;
  Comments({
    this.postid,
    this.cret,

// this.pimageUrl,
  });
  @override
  CommentsState createState() =>
      CommentsState(postid: this.postid, cret: this.cret

// pimageUrl: this.pimageUrl,
          );
}

class CommentsState extends State<Comments> {
  TextEditingController commentsController = TextEditingController();
  String postid;

  String cret;
//String pimageUrl;

  CommentsState({this.postid, this.cret

// this.pimageUrl,
      });
  buildComments(Auth auth) {
    auth1 = auth.currentUser.id;
    return StreamBuilder(
      stream: commentRef
          .document(postid)
          .collection('comments')
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        postid1 = postid;
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<Comment> comments = [];
        snapshot.data.documents.forEach((doc) {
          comments.add((Comment.fromDocument((doc))));
        });
        return ListView(
          children: comments,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: scaffoldBackgroundColor,
            title: Text(
              "Comments",
              style: Theme.of(context).textTheme.title,
            ),
            leading: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Expanded(child: buildComments(auth)),
              Divider(),
              ListTile(
                title: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                  controller: commentsController,
                  decoration: InputDecoration(labelText: 'Write a comment...'),
                ),
                trailing: OutlineButton(
                    onPressed: () {
                      Firestore.instance
                          .collection("Notifications")
                          .document(cret)
                          .collection("Notifications")
                          .document()
                          .setData({
                        "name": auth.currentUser.name,
                        "message":
                            "Commented " + '"' + commentsController.text + '"',
                        "time": timestamps,
                        "avatarUrl": auth.currentUser.photo
                      });
                      commentRef.document(postid).collection('comments').add({
                        'username': auth.currentUser.name,
                        'comment': commentsController.text,
                        'timestamp': timestamps,
                        'avatarUrl': auth.currentUser.photo,
                        'userId': auth.currentUser.id,
                      });
                      commentsController.clear();
                    },
                    borderSide: BorderSide.none,
                    child: Icon(LineIcons.paper_plane, size: 30.0)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
  final String avatarUrl;
  final String comment;
  final Timestamp timestamp;
  var f = false;

  var docid;
  Comment(
      {this.docid,
      this.username,
      this.userId,
      this.avatarUrl,
      this.comment,
      this.timestamp});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc['username'],
      userId: doc['userId'],
      avatarUrl: doc['avatarUrl'],
      comment: doc['comment'],
      timestamp: doc['timestamp'],
      docid: doc.documentID,
    );
  }
  @override
  Widget build(BuildContext context) {
    if (auth1 == userId) {
      f = true;
    }
    return Column(
      children: <Widget>[
        ListTile(
          title: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: f == true
                    ? InkWell(
                        onTap: () {
                          commentRef
                              .document(postid1)
                              .collection('comments')
                              .document(docid)
                              .delete();
                        },
                        child: Icon(
                          Icons.close,
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  username,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 0.7,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  comment,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          leading: MyCircleAvatar(imgUrl: avatarUrl),
          subtitle: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Text(timeago.format(timestamp.toDate()),
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.grey)),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
