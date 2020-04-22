import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconnect/models/courses.dart';
import 'package:iconnect/utils/colors.dart';
import 'course.dart';

class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
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

  void sendName() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CoursePage(
        courseName: coursesList[indexNum].name,
        courseId: coursesList[indexNum].id,
        courseCredit: coursesList[indexNum].credit,
        courseLab: coursesList[indexNum].lab,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
elevation: 0,
    brightness: Brightness.light,
    backgroundColor: scaffoldBackgroundColor,
    title: Text(
      "Courses",
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
              color: Color(0xffbbd1c5),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.black),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      leading: Material(
                        elevation: 10.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          child: Text(
                            coursesList[index].id,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.white,
                          radius: 30.0,
                        ),
                      ),
                      title: Text(
                        coursesList[index].name,
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: FlatButton(
                        child: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          setState(() {
                            indexNum = index;
                          });
                          sendName();
                        },
                      ),
                    ),
                  );
                },
                itemCount: coursesList.length,
              ),
            ),
          ),
          
        ],
      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      floatingActionButton: FloatingActionButton(
//        onPressed: null,
//        child: Icon(Icons.add),
//      ),
//      bottomNavigationBar: BottomAppBar(
//        shape: CircularNotchedRectangle(),
//        notchMargin: 4.0,
//        child: Row(
//          children: <Widget>[
//            FlatButton(
//              onPressed: () {},
//              child: Icon(Icons.home),
//            ),
//            FlatButton(
//              onPressed: () {},
//              child: Icon(Icons.search),
//            ),
//            FlatButton(
//              onPressed: () {},
//              child: Icon(Icons.notifications),
//            ),
//            FlatButton(
//              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
//              onPressed: () {},
//              child: Icon(Icons.perm_identity),
//            ),
//          ],
//        ),
//      ),
    );
  }
}