import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/widgets/alert_dialog.dart';
import 'package:iconnect/widgets/appbar.dart';
import 'package:iconnect/widgets/camera_bottom_sheet.dart';
import 'package:iconnect/widgets/custom_toggle2.dart';
import 'package:iconnect/widgets/profile_edit_text_field.dart';
import 'package:iconnect/widgets/shared_appbar_buttons.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _reenterPasswordController;
  GlobalKey<FormState> _formKey;
  Map<String, String> formData;

  bool _loading = false;
  File _userImage;
  @override
  void initState() {
    _reenterPasswordController = TextEditingController();
    formData = {
      'email': '',
      'password': '',
      'bio': '',
      'name': '',
      'username': '',
      'oldpassword': '',
      'major': '',
    };
    _userImage = null;

    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  void majorCallback(int pos) {
    if (pos == 0)
      formData['major'] = 'CS';
    else if (pos == 1)
      formData['major'] = 'CIS';
    else
      formData['major'] = 'CYS';

    print(formData['major']);
  }

  void validateForm() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      _formKey.currentState.save();

      if (formData['email'].trim().isNotEmpty ||
          formData['password'].trim().isNotEmpty) {
        var txt = await showDialog<String>(
            context: context,
            builder: (ctx) => buildTextDialog(_reenterPasswordController));

        if (txt == null || txt.isEmpty) {
          showDialog(
              context: context,
              builder: (ctx) => CustomAlertDialog(
                    headerText: 'Error',
                    errorMessage:
                        'Password is required to change email or password',
                  ));
          setState(() {
            _loading = false;
          });
        } else {
          formData['oldpassword'] = txt;
          var result = await Provider.of<Auth>(context, listen: false)
              .updateUserInfo(
                  formData['name'],
                  formData['username'],
                  formData['email'],
                  formData['password'],
                  formData['bio'],
                  formData['oldpassword'],
                  formData['major']);

          await showDialog(
              context: context,
              builder: (ctx) => CustomAlertDialog(
                    headerText: result.result ? 'Success' : 'Error',
                    errorMessage: result.message,
                  ));
          Navigator.of(context).pop();
        }
      } else {
        var result = await Provider.of<Auth>(context, listen: false)
            .updateUserInfo(
                formData['name'],
                formData['username'],
                formData['email'],
                formData['password'],
                formData['bio'],
                formData['oldpassword'],
                formData['major']);

        await showDialog(
            context: context,
            builder: (ctx) => CustomAlertDialog(
                  headerText: result.result ? 'Success' : 'Error',
                  errorMessage: result.message,
                ));

        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildSharedAppBar(context, 'Edit Profile',
          leading: buidSharedBackButton(context),
          action: _loading
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SpinKitFadingCircle(
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : CupertinoButton(
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: validateForm,
                )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(),
            width: double.infinity,
            child: Consumer<Auth>(
              builder: (ctx, auth, child) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: _userImage == null
                            ? NetworkImage(auth.currentUser.photo)
                            : FileImage(_userImage),
                        radius: 65,
                      ),
                      CupertinoButton(
                        child: Text(
                          'Change profile picture',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: primaryColor),
                        ),
                        onPressed: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (ctx) {
                                return CameraBottomSheet(
                                  getImage: (f) {
                                    setState(() {
                                      _userImage = f;
                                    });
                                    auth.updatePhoto(f);
                                  },
                                  message: 'Pick a new photo for your profile',
                                  title: 'Profile Picture',
                                );
                              });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ProfileEditTextField(
                        labelText: 'Name',
                        initialValue: auth.currentUser.name,
                        onSaved: (val) => formData['name'] = val,
                        onValidated: (String val) {
                          if (val.trim().isEmpty)
                            return 'This field can not be empty';
                          else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ProfileEditTextField(
                        labelText: 'Username',
                        initialValue: auth.currentUser.username,
                        onSaved: (val) => formData['username'] = val,
                        onValidated: (String val) {
                          if (val.trim().isEmpty)
                            return 'This field can not be empty';
                          else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ProfileEditTextField(
                        labelText: 'Bio',
                        initialValue: auth.currentUser.bio,
                        onSaved: (String val) => formData['bio'] = val,
                        onValidated: (String val) {
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomToggle2(
                        startPos: auth.currentUser.major == 'CS'
                            ? Alignment.centerLeft
                            : (auth.currentUser.major == 'CIS'
                                ? Alignment.center
                                : Alignment.centerRight),
                        option1Text: 'CS',
                        option2Text: 'CIS',
                        option3Text: 'CYS',
                        callback: majorCallback,
                        totalWidth: totalWidth,
                        bgColor: threeTogglesColor2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Private Information',
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ProfileEditTextField(
                        labelText: 'Email',
                        onSaved: (val) {
                          if (val == auth.currentUser.email)
                            return formData['email'] = '';
                          else
                            return formData['email'] = val;
                        },
                        initialValue: auth.currentUser.email,
                        onValidated: (String val) {
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val))
                            return 'Please provider a valid email';
                          else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ProfileEditTextField(
                        labelText: 'Password',
                        initialValue: 'password',
                        obsecureText: true,
                        onSaved: (val) {
                          if (val == 'password')
                            formData['password'] = '';
                          else
                            formData['password'] = val;
                        },
                        onValidated: (String val) {
                          if (val.trim().isEmpty && val.trim().length >= 6)
                            return 'Password must be at least 6 characters';
                          else
                            return null;
                        },
                      ),
                       
 
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[30],
    );
  }

  Widget buildTextDialog(TextEditingController _ctrl) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              obscureText: true,
              style:
                  Theme.of(context).textTheme.subtitle.copyWith(fontSize: 16),
              controller: _ctrl,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Enter your password', hintText: ''),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            }),
        new FlatButton(
            child: const Text('Submit'),
            onPressed: () {
              Navigator.pop(context, _ctrl.text);
            })
      ],
    );
  }
}
