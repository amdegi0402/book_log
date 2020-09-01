import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_meter/presentation/start/satart_model.dart';
import 'package:book_meter/presentation/menu/menu_page.dart';
import 'package:book_meter/presentation/book_list/book_list_page.dart';


class StartPage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){

    return ChangeNotifierProvider<StartModel>(
     create: (_) => StartModel(),
     child: Scaffold(
       body: Consumer<StartModel>(
         builder: (context, model, child){
           String userId = model.userId;
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