import 'package:flutter/material.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/models/post.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/profile/user_following.dart';
import 'package:iconnect/views/tabs/profile/user_liked_posts.dart';
import 'package:iconnect/views/tabs/profile/user_posts.dart';
import 'package:iconnect/widgets/custom_toggle2.dart';
import 'package:iconnect/widgets/custom_toggle3.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  OMIcons.edit,
                  color: Colors.black87,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(editProfilePage);
                },
              ),
              IconButton(
                icon: Icon(
                  OMIcons.exitToApp,
                  color: Colors.black87,
                  size: 30,
                ),
                onPressed: () {
                  auth.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
              ),
            ],
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: scaffoldBackgroundColor,
            title: Text(
              auth.currentUser.name,
              style: Theme.of(context).textTheme.title,
            ),
            centerTitle: true,
            leading: Padding(
              child: Image.asset('assets/images/shareicon.png'),
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: totlaHeigt * 0.35,
                decoration: BoxDecoration(color: Colors.grey[30]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.3),
                              offset: Offset(0, 2),
                              blurRadius: 5)
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: NetworkImage(auth.currentUser.photo),
                      ),
                    ),
                    Spacer(),
                    Text(
                      auth.currentUser.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Spacer(),
                    Text(
                      auth.currentUser.bio,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Container(
                height: totlaHeigt * 0.07,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                decoration: BoxDecoration(
                    color: threeTogglesBackGroundColor,
                    border: Border.all(width: 2, color: instructorCardColor)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: CustomToggle3(
                    option1Text: 'Posts',
                    option3Text: 'Following',
                    bgColor: threeTogglesColor,
                    callback: navigatorToPage,
                    totalWidth: totalWidth,
                    startPos: Alignment.centerLeft,
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    UserPosts(),
                    UserFollowings(),
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
