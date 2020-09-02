import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_meter/presentation/start/satart_model.dart';


class StartPage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){

    return ChangeNotifierProvider<StartModel>(
     create: (_) => StartModel(),
     child: Scaffold(
       body: Consumer<StartModel>(
         builder: (context, model, child){
           model.checkLoginUsers(context);
           //final users = model.user;
           //naviPage(context,userId);
            return Center(
              child: Text("Loading・・・"),
            );
         }
       ),
     ) 
    );
  }
}