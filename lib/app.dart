import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/_routing/router.dart' as router;

import 'package:iconnect/core/services/auth.dart';
import 'package:iconnect/theme.dart';
import 'package:iconnect/utils/colors.dart';

import 'package:provider/provider.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.dark,
      //statusBarBrightness: Brightness.dark // status bar color
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (_) => Auth(),
        
        ), 

     
        
      ],
      child: MaterialApp(
        title: 'iconnect',
        debugShowCheckedModeBanner: false,
        theme: buildThemeData(),
        onGenerateRoute: router.generateRoute,
        initialRoute: welcomeScreen,
       
       
      ),
    );
  }
}
