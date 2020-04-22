import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/models/user.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/utils/utils.dart';
import 'package:iconnect/views/tabs/admin/admin_home_screen.dart';
import 'package:iconnect/views/tabs/login/landing.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<User> _future;
  @override
  void initState() {
    _future = Provider.of<Auth>(context, listen: false).trySignIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: FutureBuilder(
        future: _future,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Spacer(
                    flex: 2,
                  ),
                  Image.asset(
                    AvailableImages.appLogo,
                    fit: BoxFit.contain,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  SpinKitFadingCircle(
                    size: 50,
                    color: primaryColor,
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            );
           else {
            if (snap.data == null)
              return LandingPage();
            else {
              if (snap.data.isAdmin)
                return AdminHomePage();
              else
                return HomePage();
            }
          }
        },
      ),
    );
  }
}
