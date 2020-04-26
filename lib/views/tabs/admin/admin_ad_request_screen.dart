import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconnect/core/services/database.dart';
import 'package:iconnect/locator.dart';
import 'package:iconnect/models/ad_request.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/notifications/fullPhoto.dart';
import 'package:line_icons/line_icons.dart';

class AdminRequestAdPage extends StatefulWidget {
  final AdRequest adRequest;
  AdminRequestAdPage(this.adRequest);
  @override
  _AdminRequestAdPageState createState() => _AdminRequestAdPageState();
}

class _AdminRequestAdPageState extends State<AdminRequestAdPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = Row(children: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    ]);

    final pageTitle = Container(
      child: Text(
        "Advertisment Request",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 35.0,
        ),
      ),
    );

    final formFieldSpacing = SizedBox(
      height: 30.0,
    );
    final registerForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(
                  LineIcons.suitcase,
                  color: Colors.black38,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
              initialValue: widget.adRequest.businessName,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
            ),
            formFieldSpacing,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Icon(
                    LineIcons.align_center,
                    color: Colors.black38,
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    initialValue: widget.adRequest.category,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FullPhoto(url: widget.adRequest.picture)));
              },
              child: Image.network(
                widget.adRequest.picture,
                fit: BoxFit.cover,
                width: 380.0,
                height: 335,
              ),
            ),
            formFieldSpacing,
            TextFormField(
              readOnly: true,
              initialValue: widget.adRequest.description,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  LineIcons.file_text,
                  color: Colors.black38,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
              keyboardType: TextInputType.text,
              maxLines: 5,
            ),
            formFieldSpacing,
          ],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              appBar,
              Container(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pageTitle,
                    registerForm,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[],
                    ),
                    formFieldSpacing,
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: RaisedButton(
                            elevation: 5.0,
                            onPressed: () {
                              locator<Database>().changeAdRequestState(
                                  'accepted', widget.adRequest.id);

                              Navigator.of(context).pop();
                            },
                            color: primaryColor,
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 40.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                            child: Text(
                              'Accept',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: RaisedButton(
                            elevation: 5.0,
                            onPressed: () {
                              locator<Database>().changeAdRequestState(
                                  'denied', widget.adRequest.id);

                              Navigator.of(context).pop();
                            },
                            color: primaryColor,
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 40.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                            child: Text(
                              'Deny',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
