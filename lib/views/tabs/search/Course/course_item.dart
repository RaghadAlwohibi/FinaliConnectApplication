import 'package:flutter/material.dart';
import 'package:iconnect/models/course.dart';
import 'package:iconnect/utils/colors.dart';

class CourseItem extends StatefulWidget {
  CourseItem({
    Key key,
    this.course,
  }) : super(key: key);

  final Course course;
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
    return Container(
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
            alignment: Alignment.center,
            child: Text(widget.course.code),
            margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [myBoxShadow],
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            widget.course.name,
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
    );
  }
}
