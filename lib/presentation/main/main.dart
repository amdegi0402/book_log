import 'package:flutter/material.dart';

import 'package:book_meter/presentation/start/start_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  
  @override
   Widget build(BuildContext context){

    return MaterialApp(
      title: "NavigatorApp",
      routes: <String, WidgetBuilder>{
         
        '/': (BuildContext context) => StartPage(),
     
      },
    );
  } 
}
