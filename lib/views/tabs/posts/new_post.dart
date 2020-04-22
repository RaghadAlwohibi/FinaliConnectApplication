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
import 'package:iconnect/widgets/camera_bottom_sheet.dart';
import 'package:iconnect/widgets/custom_toggle.dart';
import 'package:iconnect/widgets/new_post_pin.dart';
import 'package:iconnect/widgets/shared_appbar_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  Map<String, Object> formData;
  TextEditingController _addressController;
  TextEditingController _postController;
  TextEditingController _titleController;
  bool _isPosting = false;
  bool normalPost = true;
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
          type: !normalPost ? PostType.LostItem : formData['type'],
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
    formData = {
      'postText': '',
      'location': '',
      'image': null,
      'title': '',
      'type': PostType.Normal
    };
    _addressController = TextEditingController();
    _postController = TextEditingController();
    _titleController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height;
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
                option1Text: 'Post',
                option2Text: 'Lost Item',
                totalWidth: totalWidth,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      if (!normalPost)
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
                          controller: _titleController,
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
                          formData['body'] = val;
                        },
                        controller: _postController,
                        maxLines: 5,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(fontSize: 18),
                        decoration: InputDecoration(
                            hintText: 'Write your post here....',
                            hintStyle: hintStyle,
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none),
                      ),
                    ],
                  ),
                ),
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
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: GestureDetector(
                        onTap: () async {
                          var txt = await showDialog<String>(
                              context: context,
                              builder: (ctx) =>
                                  buildTextDialog(_addressController));

                          if (txt != null && txt.isNotEmpty) {
                            setState(() {
                              formData['location'] = txt;
                            });
                          }
                        },
                        child: Container(
                          child: PostBottomPin(
                            icon: Icons.location_on,
                            totalHeight: totalHeight,
                            title: 'Found At',
                            subtitle: this.formData['location'] == null ||
                                    this.formData['location'] == ''
                                ? 'Loaction here'
                                : this.formData['location'],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () async {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (ctx) => CameraBottomSheet(
                                      getImage: (File f) {
                                        setState(() {
                                          formData['image'] = f;
                                        });
                                      },
                                      title: 'Post Image',
                                      message: 'Pick an image for your post',
                                    ));
                          },
                          child: this.formData['image'] == null
                              ? Container(
                                  child: PostBottomPin(
                                    icon: Icons.camera_enhance,
                                    totalHeight: totalHeight,
                                    title: 'Picture',
                                    subtitle: 'Take a picture',
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    child: Image.file(this.formData['image']),
                                  ),
                                ),
                        ))
                  ],
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
