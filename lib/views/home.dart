import 'package:flutter/material.dart';

import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/feed/feed.dart';
import 'package:iconnect/views/tabs/notifications/notifications.dart';

import 'package:iconnect/views/tabs/profile/profile_page.dart';

import 'package:iconnect/views/tabs/search/search.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class HomePage extends StatefulWidget {
   static GlobalKey<ScaffoldState> scaffoldKey= GlobalKey<ScaffoldState>();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
 
  PageController _pageController;
  final List<Widget> _pages = [
    FeedsPage(),
    SearchPage(),
    NotificationsPage(),
    ProfilePage()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void animateToPage(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  void initState() {
    _pageController = PageController();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding:false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: HomePage.scaffoldKey,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(
                flex: 9,
                fit: FlexFit.tight,
                child: Container(
                  color: Colors.white,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[..._pages],
                    controller: _pageController,
                    onPageChanged: (index) {
                      onTabTapped(index);
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(color: Colors.white, width: 2))),
                ),
              )
            ],
          ),
          Positioned(
            child: Container(
              width: totalWidth,
            //  padding: EdgeInsets.symmetric(horizontal: totalWidth * 0.07),
              child: Container(
                alignment: Alignment.center,
                height: totalHeight * 0.1,
                decoration: BoxDecoration(
                  boxShadow: [myBoxShadow],
                  color: Colors.white,
                  //borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        OMIcons.home,
                        size: 35,
                        color: _currentIndex == 0 ? Colors.black : Colors.grey,
                      ),
                      onPressed: () {
                        animateToPage(0);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        OMIcons.search,
                        size: 35,
                        color: _currentIndex == 1 ? Colors.black : Colors.grey,
                      ),
                      onPressed: () {
                        animateToPage(1);
                      },
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    IconButton(
                      icon: Icon(
                        OMIcons.notifications,
                        size: 35,
                        color: _currentIndex == 2 ? Colors.black : Colors.grey,
                      ),
                      onPressed: () {
                        animateToPage(2);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        OMIcons.personOutline,
                        size: 35,
                        color: _currentIndex == 3 ? Colors.black : Colors.grey,
                      ),
                      onPressed: () {
                        animateToPage(3);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            bottom: totalHeight * 0.008,
          ),
          Positioned(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(newPostPage);
              },
              child: Container(
                width: 67,
                height: 67,
                child: Icon(
                  OMIcons.add,
                  size: 35,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: centerAddButtonColor.withOpacity(0.6),
                      blurRadius: 5,
                      spreadRadius: 5)
                ], shape: BoxShape.circle, color: centerAddButtonColor),
              ),
            ),
            bottom: totalHeight * 0.050,
            right: 1,
            left: 1,
          )
        ],
      ),
    );
  }
}
