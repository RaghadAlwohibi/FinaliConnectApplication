import 'package:flutter/material.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/utils/utils.dart';
import 'package:iconnect/widgets/appbar.dart';

class SearchPage extends StatefulWidget {
  static const String route = 'search-page';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<CustomWidgetClass> leftList;
  List<CustomWidgetClass> rightList;
  List<CustomWidgetClass> bottomList;
  List<CustomWidgetClass> leftListCopy;
  List<CustomWidgetClass> rightListCopy;
  List<CustomWidgetClass> bottomListCopy;
  void searchCards(String text) {
    setState(() {
      leftListCopy = leftList
          .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      rightListCopy = rightList
          .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      bottomListCopy = bottomList
          .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    leftList = [
      CustomWidgetClass(
          name: 'courses',
          widget: buildSearchCards(
              context: context,
              title: 'Courses',
              route: courseList,
              pathToIcon: AvailableImages.courseImage,
              height: 250,
              color: coursesCardColor)),
      CustomWidgetClass(
          name: 'majors',
          widget: buildSearchCards(
              context: context,
              title: 'Majors',
              route: majorList,
              pathToIcon: AvailableImages.majorImage,
              height: 200,
              color: majorsCardColor)),
      CustomWidgetClass(
          name: 'events',
          widget: buildSearchCards(
              context: context,
              title: 'Events',
              route: eventsPage,
              pathToIcon: AvailableImages.eventImage,
              height: 250,
              color: eventsCardColor))
    ];
    rightList = [
      CustomWidgetClass(
          name: 'instructors',
          widget: buildSearchCards(
              context: context,
              title: 'Instructors',
              route: instructorList,
              pathToIcon: AvailableImages.instructorImage,
              height: 200,
              color: instructorCardColor)),
      CustomWidgetClass(
          name: 'clubs',
          widget: buildSearchCards(
              context: context,
              title: 'Clubs',
              route: clubsList,
              pathToIcon: AvailableImages.clubImage,
              height: 250,
              color: clubsCardColor)),
      CustomWidgetClass(
          name: 'lost items',
          widget: buildSearchCards(
              context: context,
              title: 'Lost Items',
              route: lostItemPage,
              pathToIcon: AvailableImages.lostItemImage,
              height: 200,
              color: lostCardColor))
    ];
    bottomList = [
      CustomWidgetClass(
          name: 'advertisment',
          widget: buildSearchCards(
              context: context,
              route: adsPage,
              title: 'Advertisments',
              pathToIcon: AvailableImages.adsImage,
              height: 200,
              color: adsCardColor))
    ];

    leftListCopy = leftList;
    rightListCopy = rightList;
    bottomListCopy = bottomList;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          appBar: buildSharedAppBar(
            context,
            'Menu',
            
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.only(bottom: 30),
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: deviceWidth / 2 - 15,
                        padding: EdgeInsetsDirectional.only(end: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ...leftListCopy.map((item) => item.widget).toList()
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.only(start: 5),
                        width: deviceWidth / 2 - 15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ...rightListCopy.map((item) => item.widget).toList()
                          ],
                        ),
                      )
                    ],
                  ),
                  ...bottomListCopy.map((item) => item.widget).toList()
                ],
              ),
            ),
          )),
    );
  }
}
Widget buildSearchCards(
    {BuildContext context,
    double height,
    Color color,
    String pathToIcon,
    Function onClick,
    String title,
    String route}) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed(route);
    },
    child: Container(
      margin: EdgeInsetsDirectional.only(top: 15),
      width: double.infinity,
      height: height,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(pathToIcon),
          Text(title, style: Theme.of(context).textTheme.title)
        ],
      ),
    ),
  );
}

class CustomWidgetClass {
  String name;
  Widget widget;

  CustomWidgetClass({this.name, this.widget});
}
