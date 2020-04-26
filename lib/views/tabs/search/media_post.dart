import 'package:flutter/material.dart';
import 'package:iconnect/views/tabs/search/Course/course.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MediaPost extends StatefulWidget {
  String id;
  MediaPost({this.id});

  @override
  _MediaPostState createState() => _MediaPostState();
}

class _MediaPostState extends State<MediaPost> {
  String inputText;
  File _imageFile;
  String imgUrl;
  final Firestore _firestore = Firestore.instance;

  CoursePage coursePage = CoursePage();

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> saveImage(File image) async {
    if (_imageFile != null) {
      String filePath = '${DateTime.now()}.png';
      StorageReference ref = FirebaseStorage.instance.ref().child(filePath);
      StorageUploadTask uploadTask = ref.putFile(image);
      imgUrl = (await (await uploadTask.onComplete).ref.getDownloadURL());
    } else {
      imgUrl = ' ';
    }
    savePostReview();
  }

  Future<void> savePostReview() async {
    await _firestore
        .collection("courses")
        .document(widget.id)
        .collection('coursePosts')
        .add({'text': inputText ?? " ", 'attach': imgUrl});
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
            key: _formKey,
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Write your post here...',
              ),
              onChanged: (value) {
                inputText = value;
              },
              validator: (value) {
                if (value.isEmpty && _imageFile == null) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
            height: 15.0,
          ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color(0xFF79bda0),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: FlatButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: Text(
                    'Attach image',
                    style: TextStyle(
                      color: Color(0xFF79bda0),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color(0xFF79bda0),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          RaisedButton(
            color: Color(0xFF79bda0),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                saveImage(_imageFile);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Post',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}