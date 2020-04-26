import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/core/services/database.dart';
import 'package:iconnect/locator.dart';
import 'package:iconnect/models/post.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/utils/styles.dart';
import 'package:iconnect/widgets/alert_dialog.dart';
import 'package:iconnect/widgets/appbar.dart';
import 'package:iconnect/widgets/custom_toggle.dart';
import 'package:iconnect/widgets/shared_appbar_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AdminNewPost extends StatefulWidget {
  final bool post;
  AdminNewPost({this.post});
  @override
  _AdminNewPostState createState() => _AdminNewPostState();
}

class _AdminNewPostState extends State<AdminNewPost> {
  Map<String, Object> formData;

  TextEditingController _postController;

  bool _isPosting = false;
  bool normalPost;
  GlobalKey<FormState> _formKey = GlobalKey();

  void publishPost() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (formData['image'] == null && !normalPost) {
        showDialog(
            context: context,
            builder: (ctx) => CustomAlertDialog(
                  errorMessage:
                      'Image must be submitted in order to compelet posting',
                  headerText: 'Image is required',
                ));
        setState(() {
          _isPosting = false;
        });
        return;
      }

      var postImageUrl;
      if (formData['image'] != null) {
        postImageUrl = await locator<Database>().uploadImage(formData['image']);
      }
      var post = Post(
          body: formData['body'],
          location: formData['location'],
          likes: [],
          type: !normalPost ? PostType.Event : formData['type'],
          id: Uuid().v4(),
          title: formData['title'],
          imageUrl: postImageUrl,
          userId: Provider.of<Auth>(context, listen: false).currentUser.id,
          createdAt: DateTime.now().millisecondsSinceEpoch);
      locator<Database>().uploadPost(post);
      Navigator.of(context).pop();
    } else
      setState(() {
        _isPosting = false;
      });
  }

  void toggleCallBack(bool right) {
    setState(() {
      normalPost = !right;
    });
  }

  @override
  void initState() {
    normalPost = widget.post;
    formData = {
      'body': '',
      'location': '',
      'image': null,
      'title': '',
      'type': PostType.Normal
    };

    _postController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: buildSharedAppBar2(context: context, actions: [
        buildAppbarCancelButton(context),
        Text(
          'New Post',
          style: Theme.of(context).textTheme.title,
        ),
        _isPosting
            ? SpinKitFadingCircle(
                color: Theme.of(context).primaryColor,
                size: 25,
              )
            : buildAppbarGenericButton(
                context: context,
                function: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _isPosting = true;
                  });
                  publishPost();
                },
                title: 'Post')
      ]),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomToggle(
                callback: toggleCallBack,
                option1Text: 'Announcment',
                option2Text: 'Event',
                totalWidth: totalWidth,
                intitalIndex: widget.post ? 0 : 1,
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: normalPost
                        ? Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (val) {
                                  if (val.trim().isEmpty)
                                    return 'This feild can not be empty';
                                  else
                                    return null;
                                },
                                onSaved: (val) {
                                  formData['body'] = val;
                                },
                                controller: _postController,
                                maxLines: 5,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(fontSize: 18),
                                decoration: InputDecoration(
                                    hintText: 'Write your announcment here....',
                                    hintStyle: hintStyle,
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none),
                              ),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (val) {
                                  if (val.trim().isEmpty)
                                    return 'This feild can not be empty';
                                  else
                                    return null;
                                },
                                onSaved: (val) {
                                  formData['title'] = val;
                                },
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(fontSize: 18),
                                decoration: InputDecoration(
                                    hintText: 'Title',
                                    hintStyle: hintStyle,
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none),
                              ),
                              TextFormField(
                                validator: (val) {
                                  if (val.trim().isEmpty)
                                    return 'This feild can not be empty';
                                  else
                                    return null;
                                },
                                onSaved: (val) {
                                  formData['location'] = val;
                                },
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(fontSize: 18),
                                decoration: InputDecoration(
                                    hintText: 'Link',
                                    hintStyle: hintStyle,
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none),
                              ),
                              TextFormField(
                                validator: (val) {
                                  if (val.trim().isEmpty)
                                    return 'This feild can not be empty';
                                  else
                                    return null;
                                },
                                onSaved: (val) {
                                  formData['body'] = val;
                                },
                                maxLines: 5,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(fontSize: 18),
                                decoration: InputDecoration(
                                    hintText: 'Description',
                                    hintStyle: hintStyle,
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none),
                              ),
                            ],
                          )),
              ),
              if (normalPost)
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: appBarBorderColor, width: 2))),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.image,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () async {
                          File image = await ImagePicker.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 500,
                              maxWidth: 500);
                          if (image != null) {
                            setState(() {
                              formData['image'] = image;
                            });
                          }
                        },
                      ),
                       
                      IconButton(
                        icon: Icon(
                          Icons.photo_camera,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () async {
                          File image = await ImagePicker.pickImage(
                              source: ImageSource.camera,
                              maxHeight: 500,
                              maxWidth: 500);
                          if (image != null) {
                            setState(() {
                              formData['image'] = image;
                            });
                          }
                        },
                      ),
                      Spacer(
                        flex: 4,
                      ),
                       
                      Spacer(
                        flex: 1,
                      ),
                      formData['image'] == null
                          ? SizedBox.shrink()
                          : CircleAvatar(
                              backgroundImage: FileImage(formData['image']),
                            )
                    ],
                  ),
                ),
              if (!normalPost)
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: appBarBorderColor, width: 2))),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.image,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () async {
                          File image = await ImagePicker.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 500,
                              maxWidth: 500);
                          if (image != null) {
                            setState(() {
                              formData['image'] = image;
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.photo_camera,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () async {
                          File image = await ImagePicker.pickImage(
                              source: ImageSource.camera,
                              maxHeight: 500,
                              maxWidth: 500);
                          if (image != null) {
                            setState(() {
                              formData['image'] = image;
                            });
                          }
                        },
                      ),
                      Spacer(),
                      formData['image'] == null
                          ? SizedBox.shrink()
                          : CircleAvatar(
                              backgroundImage: FileImage(formData['image']),
                            )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextDialog(TextEditingController _ctrl) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              style:
                  Theme.of(context).textTheme.subtitle.copyWith(fontSize: 16),
              controller: _ctrl,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Location',
                  hintText: 'Location where item was found.'),
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
