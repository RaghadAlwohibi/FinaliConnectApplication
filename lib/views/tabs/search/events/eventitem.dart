import 'package:flutter/material.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/models/event.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/views/tabs/feed/comments.dart';
import 'package:url_launcher/url_launcher.dart';

class EvDetailPage extends StatefulWidget {
  final data;
  EvDetailPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _EvDetailPageState createState() => _EvDetailPageState(data);
}

class _EvDetailPageState extends State<EvDetailPage> {
  var data;

  _EvDetailPageState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
        // Row(
                    //   children: <Widget>[
                    //     SizedBox(
                    //       width: 30,
                    //       height: 30,
                    //     ),
                    //     Expanded(
                    //         child: InkWell(
                    //       onTap: () async {
                    //         if (await canLaunch(data["location"])) {
                    //           await launch(data["location"]);
                    //         } else {
                    //           throw 'Could not launch ${data["location"]}';
                    //         }
                    //       },
                    //       child: Text(
                    //         data["location"],
                    //         style: TextStyle(
                    //             color: Colors.blue,
                    //             decoration: TextDecoration.underline),
                    //       ),
                    //     )),
                    //   ],
                    // ),
     appBar: AppBar(
            bottom: PreferredSize(
                child: Container(
                  color: Colors.grey,
                  height: 0.5,
                ),
                preferredSize: Size.fromHeight(4.0)),
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: scaffoldBackgroundColor,
            title: Text(data["title"],
              style: Theme.of(context).textTheme.title,
            ),
            leading: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
      body: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: EdgeInsets.only(bottom: 20.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    child: Image.network(
                      data["imageUrl"],
                      height: MediaQuery.of(context).size.height - 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          data["title"],
                          style: TextStyle(
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Text(data["body"])),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Text("Location : " + data["location"])),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
