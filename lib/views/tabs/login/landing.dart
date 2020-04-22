import 'package:flutter/material.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/utils/utils.dart';
import 'package:iconnect/widgets/form_button.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Container(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FormButton(
                  text: 'Sign In',
                  onPressed: () =>
                      Navigator.of(context).pushNamed(loginViewRoute),
                ),
                SizedBox(
                  height: 10,
                ),
                FormButton(
                  text: 'Register',
                  onPressed: () =>
                      Navigator.of(context).pushNamed(registerViewRoute),
                ),
              ],
            ),
            Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
