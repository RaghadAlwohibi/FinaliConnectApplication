import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MultiPicker extends StatelessWidget {
  final Function function;
  final List<String> list;
  final int initial;
  MultiPicker({this.function, this.list, this.initial});

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: initial);
    return Container(
      color: Colors.white,
      height: 300,
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            alignment: Alignment.centerRight,
            width: double.infinity,
            child: CupertinoButton(
              child: Text('done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Expanded(
            child: CupertinoPicker.builder(
              backgroundColor: Colors.white,
              scrollController: scrollController,
              itemExtent: 35,
              onSelectedItemChanged: function,
              childCount: list.length,
              itemBuilder: (ctx, index) => Text(list[index]),
            ),
          ),
        ],
      ),
    );
  }
}
