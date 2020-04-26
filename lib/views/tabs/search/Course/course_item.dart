import 'package:flutter/material.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/search/Course/course.dart';

class CourseItem extends StatefulWidget {
  CourseItem({
    Key key,
    this.course,
  }) : super(key: key);

  final String course;
  @override
  _CourseItemState createState() => _CourseItemState();
}

class _CourseItemState extends State<CourseItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CoursePage(
            courseName:
                widget.course.substring(0, widget.course.lastIndexOf("/")),
            numb: int.parse(widget.course.substring(
                widget.course.lastIndexOf("/") + 1,
                widget.course.lastIndexOf("++"))),
            courseId: widget.course.substring(
                widget.course.lastIndexOf("++") + 2,
                widget.course.lastIndexOf("--")),
            courseCredit: int.parse(widget.course.substring(
                widget.course.lastIndexOf("*") + 1, widget.course.length)),
            courseLab: widget.course.substring(
                widget.course.lastIndexOf("--") + 2,
                widget.course.lastIndexOf("*")),
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
            color: instructorListColor,
            border: Border.all(color: appBarBorderColor, width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           
            Container(
              child: Row(children: <Widget>[
                SizedBox(width: 5.5),
                Text(widget.course.substring(
                  widget.course.lastIndexOf("++") + 2,
                  widget.course.lastIndexOf("--")), style: TextStyle(fontSize: 12))
              ],)
               ,

              margin: EdgeInsets.only(right: 0.0, bottom: 10.0),
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [myBoxShadow],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 6.0,
            ),
            Text(
              widget.course.substring(0, widget.course.lastIndexOf("/")),
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Spacer(),
            // IconButton(
            //   icon: Icon(Icons.arrow_forward_ios),
            //   onPressed: () {
            //     Navigator.of(context)
            //         .pushNamed(coursesDetailsPage, arguments: widget.course);
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
