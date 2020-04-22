import 'package:flutter/material.dart';
import 'package:iconnect/utils/colors.dart';

class CustomToggle2 extends StatefulWidget {
  final Function callback;
  final String option1Text;
  final String option2Text;
  final String option3Text;
  final Alignment startPos;
  final totalWidth;
  final Color bgColor;

  CustomToggle2(
      {this.totalWidth,
      this.callback,
      this.startPos = Alignment.center,
      this.option1Text,
      this.bgColor = threeTogglesColor,
      this.option2Text,
      this.option3Text});

  @override
  _CustomToggle2State createState() => _CustomToggle2State();
}

class _CustomToggle2State extends State<CustomToggle2> {
  Alignment _align;

  @override
  void initState() {
    _align = widget.startPos;
    super.initState();
  }

  void flip(Alignment to) {
    setState(() {
      _align = to;
    });
    if (to == Alignment.centerLeft) {
      widget.callback(0);
    } else if (to == Alignment.center) {
      widget.callback(1);
    } else
      widget.callback(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      //padding: EdgeInsets.all(5),
      width: widget.totalWidth,
      decoration: BoxDecoration(
          color: newPostPinColors, borderRadius: BorderRadius.circular(9)),
      // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: widget.bgColor, borderRadius: BorderRadius.circular(10)),
          ),
          AnimatedAlign(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: _align,
            child: GestureDetector(
              onTap: () {
                flip(Alignment.center);
              },
              //onHorizontalDragStart: (dir){dir.},
              child: Container(
                padding: EdgeInsets.all(5),
                height: 30,
                width: widget.totalWidth / 3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    boxShadow: [myBoxShadow],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          Align(
            child: GestureDetector(
              onTap: () {
                flip(Alignment.centerRight);
              },
              child: Container(
                color: Colors.transparent,
                child: Text(
                  widget.option3Text,
                  style: TextStyle(fontSize: 16),
                ),
                height: 30,
                width: widget.totalWidth / 3,
                alignment: Alignment.center,
              ),
            ),
            alignment: Alignment.centerRight,
          ),
          Align(
            child: GestureDetector(
              onTap: () {
                flip(Alignment.center);
              },
              child: Container(
                color: Colors.transparent,
                child: Text(
                  widget.option2Text,
                  style: TextStyle(fontSize: 16),
                ),
                height: 30,
                width: widget.totalWidth / 3,
                alignment: Alignment.center,
              ),
            ),
            alignment: Alignment.center,
          ),
          Align(
            child: GestureDetector(
              onTap: () {
                flip(Alignment.centerLeft);
              },
              child: Container(
                color: Colors.transparent,
                child: Text(
                  widget.option1Text,
                  style: TextStyle(fontSize: 16),
                ),
                height: 30,
                width: widget.totalWidth / 3,
                alignment: Alignment.center,
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }
}
