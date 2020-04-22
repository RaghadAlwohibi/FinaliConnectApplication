import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FormButton extends StatelessWidget {
  final Function onPressed;
  final bool loading;
  final String text;
  FormButton({this.text, this.onPressed, this.loading = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: loading
            ? SpinKitFadingCircle(
                color: Colors.white,
                size: 50,
              )
            : Text(
                text,
                style:
                    Theme.of(context).textTheme.button.copyWith(fontSize: 18),
              ),
      ),
    );
  }
}
