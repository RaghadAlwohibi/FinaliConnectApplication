import 'package:flutter/material.dart';
import 'package:iconnect/utils/colors.dart';

class ProfileEditTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obsecureText;
  final Function onSaved;
  final Function onValidated;
  final String initialValue;
  final int maxLines;
  final TextEditingController controller;
  ProfileEditTextField(
      {this.hintText,
      this.labelText,
      this.initialValue,
      this.maxLines = 1,
      this.obsecureText = false,
      this.onSaved,
      this.onValidated,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
              child: TextFormField(
                maxLines: maxLines,
                onSaved: onSaved,
                controller: controller,
                initialValue: initialValue,
                validator: onValidated,
                obscureText: obsecureText,
                style:
                    Theme.of(context).textTheme.subtitle.copyWith(fontSize: 16),
                decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  hintStyle: TextStyle(color: fadedTextColor, fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.5, color: profileEditTextFieldBorder),
                      borderRadius: BorderRadius.circular(30)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: profileEditTextFieldBorder),
                      borderRadius: BorderRadius.circular(30)),
                ),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
            child: Text(
              labelText,
              style:
                  Theme.of(context).textTheme.subtitle.copyWith(fontSize: 16),
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
          )
        ],
      ),
    );
  }
}
