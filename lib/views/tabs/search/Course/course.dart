import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconnect/models/course_idMap.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/notifications/fullPhoto.dart';
import 'package:iconnect/views/tabs/search/media_post.dart';
import 'package:iconnect/widgets/alert_dialog.dart';
import 'package:iconnect/widgets/course_review.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CoursePage extends StatefulWidget {
  final String courseName;
  final String courseId;
  final String courseLab;
  final num courseCredit;
  CoursePage({
    this.courseName,
    this.courseId,
    this.courseCredit,
    this.courseLab,
  });

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final firestore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> courseReviewList = [];
  bool isReview = true;
  bool isPost = false;
  List<CoursePostModel> coursePostModelList = [];
  String currReviewsID;

  void getCourseReviews() async {
    CourseIdMap idMap = CourseIdMap();
    currReviewsID = idMap.ids[widget.courseId];
    final reviews = await firestore
        .collection('courses')
        .document(currReviewsID)
        .collection('review')
        .getDocuments();
    for (var review in reviews.documents) {
      courseReviewList.add(review.data['text']);
    }
    setState(() {});
  }

  void getCoursePost() async {
    CourseIdMap idMap = CourseIdMap();
    String currID = idMap.ids[widget.courseId];
    final posts = await firestore
        .collection('courses')
        .document(currID)
        .collection('coursePosts')
        .getDocuments();
    for (var post in posts.documents) {
      coursePostModelList.add(CoursePostModel(
        text: post.data['text'] ?? "",
        imgUrl: post.data['attach'] ?? "",
        
      ));
    }
    setState(() {});
  }

  Future<void> addFollow() async {
    //firebaseAuth current login user
    //Add collection for each user of followed courses.
    return showDialog(
        context: context,
        builder: (ctx) => CustomAlertDialog(
              headerText: 'Success',
              errorMessage: 'You are now following ${widget.courseName}',
            ));
  }

  Future<void> followError() async {
    //firebaseAuth current login user
    //Add collection for each user of followed courses.
    return showDialog(
        context: context,
        builder: (ctx) => CustomAlertDialog(
              headerText: 'Alert',
              errorMessage: 'You are already following ${widget.courseName}',
            ));
  }

  var userDataID;
  List<dynamic> followedCourses = [];

  Future<void> getFollowData() async {
    FirebaseUser user = await _auth.currentUser();
    String userEmail = user.email;
    var data = await firestore.collection('users').getDocuments();
    for (var d in data.documents) {
      if (d.data['email'] == userEmail) {
        userDataID = d.documentID;
        followedCourses = d.data['followed_courses'];
      }
    }
    print(followedCourses);
  }

  Future<void> followCourse() async {
    if (followedCourses.contains(widget.courseName)) {
      followError();
    } else {
      List<String> course = [];
      course.add(widget.courseName);
      await Firestore.instance
          .collection('users')
          .document(userDataID)
          .updateData({"followed_courses": FieldValue.arrayUnion(course)});
      addFollow();
    }
    getFollowData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCourseReviews();
    getCoursePost();
    getFollowData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 500.0,
                  child: MediaPost(
                    id: currReviewsID,
                  ),
                ),
              ),
            ),
            isScrollControlled: true,
          );
        },
        backgroundColor: primaryColor,
        label: Text(
          "Add post",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(
            color: Color(0xFF79bda0),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.grey,
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(4.0)),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: scaffoldBackgroundColor,
        title: Text(
          widget.courseName,
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
          Expanded(
            flex: 9,
            child: Container(
              //padding: EdgeInsets.all(20.0),
              color: Color(0xFFe4edec),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          elevation: 10.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            child: Text(
                              widget.courseId,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            backgroundColor: Colors.white,
                            radius: 50.0,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Container(
                                  width: 200,
                                  child: Text(
                                    widget.courseName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
                                    ),
                                  )),
                            ),
                            Text(
                              'Lab: ${widget.courseLab}',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Credit hours: ${widget.courseCredit}',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text('Follow'),
                    color: primaryColor,
                    padding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 50.0),
                    textColor: Colors.white,
                    onPressed: () {
                      followCourse();
                      
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.black, width: 1.0),
                      color: Color(0xffCBD2D4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 35.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            boxShadow: isPost
                                ? [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    ),
                                  ]
                                : null,
                            color: !isPost ? Color(0xffCBD2D4) : Colors.white,
                            borderRadius:
                                isPost ? BorderRadius.circular(5.0) : null,
                          ),
                          child: FlatButton(
                            child: Text(
                              'Posts',
                            ),
                            onPressed: () {
                              setState(() {
                                coursePostModelList.clear();
                                isReview = false;
                                isPost = true;
                              });
                              getCoursePost();
                            },
                          ),
                        ),
                        Container(
                          height: 35.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            color: !isReview ? Color(0xffCBD2D4) : Colors.white,
                            borderRadius:
                                isReview ? BorderRadius.circular(5.0) : null,
                            boxShadow: isReview
                                ? [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    ),
                                  ]
                                : null,
                          ),
                          child: FlatButton(
                            child: Text('Reviews'),
                            onPressed: () {
                              setState(() {
                                isReview = true;
                                isPost = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: isReview
                        ? CourseReview(
                            reviewList: courseReviewList,
                            currID: currReviewsID,
                          )
                        : Container(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Container(
                                    color: Colors.grey.shade100,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 20,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Container(
                                                width: 280,
                                                child: Text(
                                                    coursePostModelList[index]
                                                            .text ??
                                                        " "),
                                              ),
                                            ),
                                          ],
                                        ),
                                        coursePostModelList[index]
                                                    .imgUrl
                                                    .length >
                                                10
                                            ? FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              FullPhoto(
                                                                  url: coursePostModelList[
                                                                          index]
                                                                      .imgUrl)));
                                                },
                                                child: Image.network(
                                                  coursePostModelList[index]
                                                      .imgUrl,
                                                  fit: BoxFit.cover,
                                                  width: 200.0,
                                                  height: 200,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: coursePostModelList.length,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CoursePostModel {
  String text;
  String imgUrl;
  

  CoursePostModel({
    this.text,
    this.imgUrl,
  });
}