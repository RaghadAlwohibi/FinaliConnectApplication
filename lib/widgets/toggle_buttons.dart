import 'package:flutter/material.dart';

class CustomToggleButtons extends StatefulWidget {
  final parentPadding;
  CustomToggleButtons({@required this.parentPadding});

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  List<bool> _selections;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _totalAvailableWidth =
        MediaQuery.of(context).size.width - 2 * widget.parentPadding;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ToggleButtons(
          constraints:
              BoxConstraints(minWidth: _totalAvailableWidth / 3, minHeight: 42),
          onPressed: (selectedIndex) {
            setState(() {
              _selections = List.generate(3, (index) {
                if (index == selectedIndex)
                  return true;
                else
                  return false;
              });
            });
          },
          isSelected: _selections ?? [true, false, false],
          fillColor: Theme.of(context).focusColor,
          selectedColor: Theme.of(context).canvasColor,
          color: Theme.of(context).textTheme.title.color,
          renderBorder: false,
          children: <Widget>[
            Text(
              '2+',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '4+',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '5+',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
