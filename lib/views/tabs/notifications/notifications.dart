import 'package:flutter/material.dart';
import 'package:iconnect/utils/colors.dart';


import 'activity.dart';
import 'chatlist.dart';
//import 'package:outline_material_icons/outline_material_icons.dart';



class NotificationsPage extends StatefulWidget {
  

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            child: Image.asset('assets/images/shareicon.png'),
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
    elevation: 0,
    brightness: Brightness.light,
    backgroundColor: scaffoldBackgroundColor,
    title: Text(
      "Notifications",
      style: Theme.of(context).textTheme.title,
    ),
    centerTitle: true,
     bottom: TabBar(
        indicatorColor: Color(0xffbbd1c5),
        controller: _tabController,
        //unselectedLabelColor: Color(0xffbbd1c5),
             // indicatorSize: TabBarIndicatorSize.label,
              //indicator: BoxDecoration(
                  //borderRadius: BorderRadius.circular(50),
                  //color: Color(0xffbbd1c5)),
             tabs: [
                Tab(
                  child: Container(
                    //decoration: BoxDecoration(
                      //  borderRadius: BorderRadius.circular(50),
                        //border: Border.all(color: Color(0xffbbd1c5), width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Activity",
                      style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    //decoration: BoxDecoration(
                      //  borderRadius: BorderRadius.circular(50),
                       // border: Border.all(color: Color(0xffbbd1c5), width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Messages",
                      style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ]),
    
    
  ),
   body: //Stack(
 // children: <Widget>[
   TabBarView(
        controller: _tabController,
        children: <Widget>[
          ActivityScreen(),
          MainScreen(),
        ],
      ),
// Row(
    //children: <Widget>[
       // Expanded(
         //   child: Divider(color: Colors.grey[300], height: 26.0)
       // ),],
//)
 // ],
//),
 backgroundColor: Colors.grey[30],
    );
  }
}
