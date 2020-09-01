import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_meter/auth/auth_model.dart';


class ResetPassModel extends ChangeNotifier{
  //final AuthModel _auth = AuthModel(); 
  //final formGlobalKey = GlobalKey();
  String email = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailInputController = TextEditingController();

  //PW再設定
  Future sendPasswordResetEmail(String email)async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return 'success';
    }catch(error){
      return error.code;
    }
  }

   String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return '正しいEmailのフォーマットで入力してください';
    } else {
      return null;
    }
  }

}