import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseReview extends StatefulWidget {
  final List<String> reviewList;
  final String currID;
  CourseReview({this.reviewList, this.currID});

  @override
  _CourseReviewState createState() => _CourseReviewState();
}

class _CourseReviewState extends State<CourseReview> {
  final _controller = TextEditingController();

  Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  style: new TextStyle(color: Colors.black),
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Write your review here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  firestore
                      .collection('courses')
                      .document(widget.currID)
                      .collection('review')
                      .add({'text': _controller.value.text});
                  setState(() {
                    widget.reviewList.add(_controller.value.text);
                  });
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                },
                child: Icon(Icons.send),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                                  child: Container(
                                    color: Colors.grey.shade100,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                             SizedBox(
                                              width: 20,
                                            ),
                                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Container(
                               width: 280,
                              child:  Text(widget.reviewList[index]),),
                            ),],
                                        ),
                                       
                                      ],
                                    ),
                                  ),
                                );;
            },
            itemCount: widget.reviewList.length,
          ),
        ),
      ],
    );
  }
}