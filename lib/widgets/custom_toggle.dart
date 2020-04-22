import 'package:flutter/material.dart';
import 'package:iconnect/utils/colors.dart';

class CustomToggle extends StatefulWidget {
  final Function callback;
  final String option1Text;
  final String option2Text;
  final totalWidth;
  final intitalIndex;
  CustomToggle(
      {this.totalWidth,
      this.callback,
      this.option1Text,
      this.option2Text,
      this.intitalIndex = 0});

  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  bool _right;

  void flip() {
    setState(() {
      _right = !_right;
    });
    widget.callback(_right);
  }

  @override
  void initState() {
    super.initState();
    _right = widget.intitalIndex == 0 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,

      padding: EdgeInsets.all(5),
      width: widget.totalWidth * 0.75,
      decoration: BoxDecoration(
          color: newPostPinColors, borderRadius: BorderRadius.circular(9)),
      // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: _right ? widget.totalWidth * 0.7 * 0.5 : 0,
            right: _right ? 0 : widget.totalWidth * 0.7 * 0.5,
            child: GestureDetector(
              onTap: flip,
              //onHorizontalDragStart: (dir){dir.},
              child: Container(
                padding: EdgeInsets.all(5),
                height: 30,
                width: widget.totalWidth * 0.7 * 0.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    boxShadow: [myBoxShadow],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          Positioned(
            child: GestureDetector(
              onTap: flip,
              child: Container(
                child: Text(
                  widget.option1Text,
                  style: TextStyle(fontSize: 16),
                ),
                height: 30,
                width: widget.totalWidth * 0.7 * 0.5,
                alignment: Alignment.center,
              ),
            ),
            left: 0,
          ),
          Positioned(
            child: GestureDetector(
              onTap: flip,
              child: Container(
                child: Text(
                  widget.option2Text,
                  style: TextStyle(fontSize: 16),
                ),
                height: 30,
                width: widget.totalWidth * 0.7 * 0.5,
                alignment: Alignment.center,
              ),
            ),
            right: 0,
          ),
        ],
      ),
    );
  }
}
