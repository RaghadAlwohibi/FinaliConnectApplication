import 'package:flutter/material.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/views/tabs/admin/admin_home_screen.dart';

import 'package:iconnect/widgets/alert_dialog.dart';
import 'package:iconnect/widgets/form_button.dart';
import 'package:iconnect/widgets/form_textfield.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _loading;
  final _formKey = GlobalKey<FormState>();
  Map<String, String> formData;
  TextEditingController _confirmPasswordController;
  @override
  void initState() {
    _loading = false;
    formData = {'name': '', 'email': '', 'username': '', 'password': ''};
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    final pageTitle = Container(
      width: double.infinity,
      child: Text(
        "Create an account",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 24),
      ),
    );

    final formFieldSpacing = SizedBox(
      height: 10.0,
    );
    final privacyText = Text(
      'By creating an account you agree to our Terms of Service and Privacy Policy',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.subtitle,
    );

    final registerForm = Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            FormTextField(
              onValidated: (String val) {
                if (val.trim().isEmpty)
                  return 'Please write your full name';
                else
                  return null;
              },
              onSaved: (String val) {
                formData['name'] = val;
              },
              hintText: 'Full name',
              labelText: 'Name',
            ),
            formFieldSpacing,
            FormTextField(
              onValidated: (String val) {
                if (val.trim().isEmpty)
                  return 'Please write your username';
                else
                  return null;
              },
              onSaved: (String val) {
                formData['username'] = val;
              },
              hintText: 'Username',
              labelText: 'Username',
            ),
            formFieldSpacing,
            FormTextField(
              onValidated: (String val) {
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val))
                  return 'Please provider a valid email';
                else
                  return null;
              },
              onSaved: (String val) {
                formData['email'] = val;
              },
              hintText: 'Email',
              labelText: 'Email',
            ),
            formFieldSpacing,
            FormTextField(
              controller: _confirmPasswordController,
              onValidated: (String val) {
                if (val.trim().length < 6)
                  return 'Password has to be at least 6 characters.';
                else
                  return null;
              },
              onSaved: (String val) {
                formData['password'] = val;
              },
              labelText: 'Password',
              hintText: '******',
              obsecureText: true,
            ),
            formFieldSpacing,
            FormTextField(
              onValidated: (String val) {
                if (val != _confirmPasswordController.text)
                  return 'Password do not match';
                else
                  return null;
              },
              labelText: 'Confirm Password',
              hintText: '*******',
              obsecureText: true,
            ),
            formFieldSpacing,
          ],
        ),
      ),
    );

    final submitBtn = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: FormButton(
        loading: _loading,
        text: 'Create Account',
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            print(formData);
            setState(() {
              _loading = true;
            });
            // make registration logic here. All required user data are inside formData map. Access them as such; formData['name']...
            var result = await Provider.of<Auth>(context, listen: false)
                .registerWithAccount(formData['name'], formData['email'],
                    formData['password'], formData['username']);

            if (result['result'] as bool) {
              if (result['isAdmin'] as bool)
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AdminHomePage.route, (Route<dynamic> route) => false);
              else
                Navigator.of(context).pushNamedAndRemoveUntil(
                    homeViewRoute, (Route<dynamic> route) => false);
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
          }
        },
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pageTitle,
                    registerForm,
                    privacyText,
                    Divider(),
                    Text(
                      '             Already have an account?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    FlatButton(
                      child: Text(
                        '                          Login',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('login');
                      },
                    ),
                    submitBtn
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
