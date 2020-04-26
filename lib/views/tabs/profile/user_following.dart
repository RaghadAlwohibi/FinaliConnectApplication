import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/models/course.dart';
import 'package:iconnect/models/courses.dart';
import 'package:iconnect/views/tabs/search/Course/course_item.dart';
import 'package:provider/provider.dart';

class UserFollowings extends StatefulWidget {
  UserFollowings();

  @override
  _UserFollowingsState createState() => _UserFollowingsState();
}

class _UserFollowingsState extends State<UserFollowings> {
  final firestore = Firestore.instance;
  List<CoursesModel> coursesList = [];
  var indexNum;
  void getData() async {
    final courses = await firestore.collection('courses').getDocuments();
    for (var course in courses.documents) {
      coursesList.add(CoursesModel(
        name: course.data['name'],
        id: course.data['id'],
        credit: course.data['credit'],
        lab: course.data['lab'],
      ));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (ctx, auth, child) {
      return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: auth.currentUser.followed_courses.length,
          itemBuilder: (ctx, index) => CourseItem(
                course: auth.currentUser.followed_courses[index],
              ));
    });
  }
}
