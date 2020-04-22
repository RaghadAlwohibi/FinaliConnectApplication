import 'package:flutter/material.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/search/events/evposts.dart';
import 'package:iconnect/widgets/appbar.dart';
import 'package:provider/provider.dart';

class EvPage extends StatefulWidget {
  @override
  _EvPageState createState() => _EvPageState();
}

class _EvPageState extends State<EvPage> {
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
          appBar: AppBar(
            bottom: PreferredSize(
                child: Container(
                  color: Colors.grey,
                  height: 0.5,
                ),
                preferredSize: Size.fromHeight(4.0)),
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: scaffoldBackgroundColor,
            title: Text(
              'Events',
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
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    EvPosts(), //AdPosts
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
