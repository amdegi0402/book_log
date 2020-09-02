import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainModels extends ChangeNotifier{
  String topText = '状態確認';

  void changeText()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    topText = 'サインアウト完了';
    
    notifyListeners();
  }

  void checkLoginUsers()async{
    final user = await FirebaseAuth.instance.currentUser();
    try{
      final String _userId = user.uid;
      topText = "$_userId";
    
      notifyListeners();
    }catch(e){
      print(e);
    }
      
  }
}