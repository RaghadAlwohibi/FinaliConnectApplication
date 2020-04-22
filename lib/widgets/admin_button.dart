import 'package:flutter/material.dart';




class AdminButton extends StatelessWidget {
  final Function onClick;
  final String text;
  AdminButton({this.onClick, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
      width: 250,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: this.onClick,
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      
                    ),
        child: Text(
          this.text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
