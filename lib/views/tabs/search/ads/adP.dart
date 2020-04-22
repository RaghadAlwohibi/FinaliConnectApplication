import 'package:flutter/material.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/search/ads/adposts.dart';
import 'package:iconnect/views/tabs/search/request_form.dart';
import 'package:iconnect/widgets/appbar.dart';
import 'package:provider/provider.dart';

class AdPage extends StatefulWidget {
  @override
  _AdPageState createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var totlaHeigt = MediaQuery.of(context).size.height;
    var totalWidth = MediaQuery.of(context).size.width;
    void navigatorToPage(int index) {
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }

    return Consumer<Auth>(
      builder: (ctx, auth, child) {
        return Scaffold(
         
          appBar: buildSharedAppBar(
            context,
            'Advertisments',
            
            leading: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    AdPosts(),
                  ],
                ),
              )
            ],
          ),
         floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RequestAdPage()));
        },
        backgroundColor: primaryColor,
        label: Row(children: <Widget>[
          Icon(Icons.add),
          Text(
          "Request Ad",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),],),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(
            color: Color(0xFF79bda0),
          ),
        ),
        
      ),
         backgroundColor: Colors.grey[30],
        );
      },
    );
  }
}
