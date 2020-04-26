import 'package:flutter/material.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/widgets/alert_dialog.dart';
import 'package:iconnect/widgets/form_button.dart';
import 'package:iconnect/widgets/form_textfield.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String email;

  @override
  void initState() {
    email = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageTitle = Container(
      width: double.infinity,
      child: Text(
        "Forgot Password",
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
      onSaved: (String val) {
        email = val;
      },
      labelText: 'Email',
      hintText: 'Email',
    );

    final resetForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: emailField,
      ),
    );

    final submitBtn = Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30.0),
      child: FormButton(
        text: 'Send',
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            var result = await Provider.of<Auth>(context, listen: false)
                .resetPassword(email);
            if (result) {
              showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                        errorMessage: 'Email was sent to $email',
                        headerText: 'Reset Password',
                      ));
            } else {
              showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                        errorMessage: 'Email entered is invalid',
                        headerText: 'Invalid email',
                      ));
            }
          }
        },
      ),
    );

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
    final enterEmailText = Padding(
      padding: EdgeInsets.only(top: 35, bottom: 15),
      child: Text(
        'Enter the email associated with your account.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    pageTitle,
                    enterEmailText,
                    resetForm,
                    submitBtn,
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
