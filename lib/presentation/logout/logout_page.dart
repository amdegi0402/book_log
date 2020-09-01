import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_meter/presentation/logout/logout_model.dart';
import 'package:book_meter/auth/auth.dart';
import 'package:book_meter/presentation/main/main.dart';

class LogoutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<LogoutModel>(
      create: (_) => LogoutModel(),
      child: Scaffold(
        body: Consumer<LogoutModel>(
          builder: (context, model,child){
             model.logoutData();
             return AlertDialog(
              title: Text("ログアウト完了"),
              
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: (){
                   Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ],
              
            );
          }
        ),
      ),
    );
  }
  
}