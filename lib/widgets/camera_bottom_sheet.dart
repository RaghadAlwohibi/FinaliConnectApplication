import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CameraBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final Function getImage;
  CameraBottomSheet({this.title, this.getImage, this.message});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        title,
        style: TextStyle(fontSize: 30),
      ),
      message: Text(
        message,
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("From Camera"),
          isDefaultAction: true,
          onPressed: () async {
            File image = await ImagePicker.pickImage(
                source: ImageSource.camera, maxHeight: 500, maxWidth: 500);
            if (image != null) {
              getImage(image);
            }
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text("From Gallery"),
          isDefaultAction: true,
          onPressed: () async {
            File image = await ImagePicker.pickImage(
                source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);
            if (image != null) {
              getImage(image);
            }
            Navigator.pop(context);
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
