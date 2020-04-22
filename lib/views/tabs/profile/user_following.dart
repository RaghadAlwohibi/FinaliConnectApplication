import 'package:flutter/material.dart';
import 'package:iconnect/models/course.dart';
import 'package:iconnect/views/tabs/search/Course/course_item.dart';

class UserFollowings extends StatelessWidget {
  UserFollowings();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: courses.length,
        itemBuilder: (ctx, index) => CourseItem(
              course: courses[index],
            ));
  }
}
