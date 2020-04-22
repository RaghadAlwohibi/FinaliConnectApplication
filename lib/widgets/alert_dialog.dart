import 'package:flutter/material.dart';
import 'package:iconnect/utils/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String headerText;
  final String errorMessage;
  CustomAlertDialog({this.errorMessage, this.headerText});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0)), //this right here
      child: Container(
        height: 200.0,
        width: 300.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: dialogShadow.withOpacity(0.5),
                  blurRadius: 55,
                  offset: Offset(0, 15),
                  spreadRadius: 1)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(headerText.toUpperCase(),
                    style: TextStyle(
                        color: secondaryTitle,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(errorMessage,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                          color: secondaryTitle,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              Divider(),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text('OK',
                      style: TextStyle(
                          color: secondaryTitle,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
