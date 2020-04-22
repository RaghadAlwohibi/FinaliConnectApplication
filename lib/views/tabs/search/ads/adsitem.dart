import 'package:flutter/material.dart';
import 'package:iconnect/utils/colors.dart';

class DetailPage extends StatefulWidget {
  final Object data;
  DetailPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(data);
}

class _DetailPageState extends State<DetailPage> {
  var data;

  _DetailPageState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: Text(data["businessName"],
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
                      data["picture"],
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      (Icons.favorite_border),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    // onTap: () => showComments(
                    //   context,
                    //   id: data["id"],
                    
                    //   //imageURL: data.imageURL,
                    // ),
                    child: Icon(
                      (Icons.chat),
                      color: Colors.grey,
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
                        SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          data["businessName"],
                          style: TextStyle(
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Expanded(child: Text('Category: '+data["category"])),
                      ],
                    ),
                    // Row(
                    //   children: <Widget>[
                    //     SizedBox(
                    //       width: 30,
                    //       height: 30,
                    //     ),
                    //     Expanded(
                    //         child: InkWell(
                    //       onTap: () async {
                    //         if (await canLaunch(data["link"])) {
                    //           await launch(data["link"]);
                    //         } else {
                    //           throw 'Could not launch ${data["link"]}';
                    //         }
                    //       },
                    //       child: Text(
                    //         data["link"],
                    //         style: TextStyle(
                    //             color: Colors.blue,
                    //             decoration: TextDecoration.underline),
                    //       ),
                    //     )),
                    //   ],
                    // ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          ' About '+ data["businessName"],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Expanded(child: Text(data["description"])),
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

// String id;
  // int date;
  // String businessName;
  // String duration;//breif
  // String description;//description
  // String category;
  // String state; 
  // String picture; 

class DetailPage1 extends StatefulWidget {
  final data;
  DetailPage1({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _DetailPage1State createState() => _DetailPage1State(data);
}

class _DetailPage1State extends State<DetailPage1> {
  var data;

  _DetailPage1State(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title:  Text(data["businessName"],
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
                      data['picture'],
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      (Icons.favorite_border),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    // onTap: () => showComments(
                    //   context,
                    //   id: data.id,
                    //   //imageURL: data.imageURL,
                    // ),
                    child: Icon(
                      (Icons.chat),
                      color: Colors.grey,
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
                        SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          data['businessName'],
                          style: TextStyle(
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Expanded(child: Text('Category: '+data['category'])),
                      ],
                    ),
                    // Row(
                    //   children: <Widget>[
                    //     SizedBox(
                    //       width: 30,
                    //       height: 30,
                    //     ),
                    //     Expanded(
                    //         child: InkWell(
                    //       onTap: () async {
                    //         if (await canLaunch(data.link)) {
                    //           await launch(data.link);
                    //         } else {
                    //           throw 'Could not launch ${data.link}';
                    //         }
                    //       },
                    //       child: Text(
                    //         data.link,
                    //         style: TextStyle(
                    //             color: Colors.blue,
                    //             decoration: TextDecoration.underline),
                    //       ),
                    //     )),
                    //   ],
                    // ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          ' About '+data["businessName"],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Expanded(child: Text(data['description'])),
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
