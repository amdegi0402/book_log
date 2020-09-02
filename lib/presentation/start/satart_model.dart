import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_meter/presentation/menu/menu_page.dart';
import 'package:book_meter/presentation/book_list/book_list_page.dart';

class StartModel extends ChangeNotifier{
  String userId = "ID NAME";
  bool check = false;

  checkLoginUsers(context)async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    
    user != null ? user.uid : null;
    userId = user.toString();
    if(check == false){
      check = true;
      if(userId == "null"){
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MenuPage()),
        );
      }else if(userId != "null"){
       await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BookListPage()),
        );
      }
     // notifyListeners();
    }
    return;
  }
}