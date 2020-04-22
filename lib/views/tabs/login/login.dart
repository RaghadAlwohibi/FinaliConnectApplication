import 'package:flutter/material.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/views/tabs/admin/admin_home_screen.dart';

import 'package:iconnect/widgets/alert_dialog.dart';
import 'package:iconnect/widgets/form_button.dart';
import 'package:iconnect/widgets/form_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _loading;
  Map<String, String> formData;

  @override
  void initState() {
    _loading = false;
    formData = {'email': '', 'password': ''};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // // Change Status Bar Color
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(statusBarColor: primaryColor),
    // );
    final pageTitle = Container(
      width: double.infinity,
      child: Text(
        "Sign In",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 24),
      ),
    );

    final emailField = FormTextField(
      onValidated: (String val) {
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val)) {
          return 'Please provide a valid email address';
        } else
          return null;
      },
      initialValue: '',
      onSaved: (String val) {
        formData['email'] = val;
      },
      labelText: 'Email',
      hintText: 'Email',
    );

    final passwordField = FormTextField(
      onValidated: (String val) {
        if (val.trim().length < 6) {
          return 'Password is too short';
        } else
          return null;
      },
      onSaved: (String val) {
        formData['password'] = val;
      },
      initialValue: '',
      labelText: 'Password',
      hintText: '******',
      obsecureText: true,
    );

    final loginForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            emailField,
            SizedBox(
              height: 10,
            ),
            passwordField
          ],
        ),
      ),
    );

    final loginBtn = Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.0),
      child: FormButton(
        loading: _loading,
        text: 'Sign In',
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            setState(() {
              _loading = true;
            });
            print(formData);
            //make login logic here. Get user email and password like this: formData['email'],formData['password'].
            var result = await Provider.of<Auth>(context, listen: false)
                .signInWithAccount(formData['email'], formData['password']);

            if (result['result'] as bool) {
              if (result['isAdmin'] as bool)
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AdminHomePage.route, (Route<dynamic> route) => false);
              else
                Navigator.of(context).pushNamedAndRemoveUntil(
                    homeViewRoute, (Route<dynamic> route) => false);

              //Navigator.of(context).pushReplacementNamed(homeViewRoute);
            } else {
              setState(() {
                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (ctx) => CustomAlertDialog(
                        headerText: 'Error',
                        errorMessage: result['message'],
                      ));
            }
            // Navigator.pushReplacementNamed(context, homeViewRoute);
          }
        },
      ),
    );

    final forgotPassword = Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, resetPasswordViewRoute),
          child: Text(
            'Forgot Password?',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ));

    final appBar = Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              appBar,
              Container(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  children: <Widget>[
                    pageTitle,
                    loginForm,
                    forgotPassword,
                    Divider(),
                    Text(
                      'Don\'t have an account?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    FlatButton(
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('register');
                      },
                    ),
                    loginBtn,
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
