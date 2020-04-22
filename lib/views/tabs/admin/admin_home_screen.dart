import 'package:flutter/material.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/widgets/admin_button.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  static const String route = 'admin-home';
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height;

    return Consumer<Auth>(
      builder: (ctx, auth, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: PreferredSize(
                child: Container(
                  color: appBarBorderColor,
                  height: 1.0,
                ),
                preferredSize: Size.fromHeight(1.0)),
            actions: <Widget>[
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
            centerTitle: true,
            leading: Padding(
              child: Image.asset('assets/images/shareicon.png'),
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          body: Consumer<Auth>(
            builder: (ctx, model, child) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
                          height: 65.0,
                          width: 65.0,
                          decoration: BoxDecoration(
                            boxShadow: [myBoxShadow],
                            image: DecorationImage(
                              image: NetworkImage(model.currentUser.photo),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(model.currentUser.email)
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    AdminButton(
                      onClick: () {
                        Navigator.of(context)
                            .pushNamed(adminNewPost, arguments: true);
                      },
                      text: 'Add Post',
                    ),
                    AdminButton(
                      onClick: () {
                        Navigator.of(context).pushNamed(adminAdReuqests);
                      },
                      text: 'Advertisment Requests',
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
