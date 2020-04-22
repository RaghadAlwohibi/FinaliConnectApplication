import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconnect/models/club_model.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/search/club/club_page.dart';

class ClubList extends StatefulWidget {
  @override
  _ClubListState createState() => _ClubListState();
}

class _ClubListState extends State<ClubList> {
  final firestore = Firestore.instance;
  List<ClubModel> clubList = [];
  var indexNum;

  void getData() async {
    final clubs = await firestore.collection('clubs').getDocuments();
    for (var club in clubs.documents) {
      clubList.add(ClubModel(
          id: club.data['id'],
          name: club.data['name'],
          dat: club.data['Day and Time'],
          loc: club.data['Location']));
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
      return ClubPage(
        clubDat: clubList[indexNum].dat,
        clubId: clubList[indexNum].id,
        clubLoc: clubList[indexNum].loc,
        clubName: clubList[indexNum].name,
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
      "Clubs",
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
      body: Container(
        color: Color(0xffbbd1c5),
        child: Column(
          children: <Widget>[
            ListView.builder(
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
                          clubList[index].id,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        radius: 25.0,
                      ),
                    ),
                    title: Text(
                      clubList[index].name,
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
              itemCount: clubList.length,
            ),
            //Expanded(
              //child: NavbarWidget(),
            //),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
