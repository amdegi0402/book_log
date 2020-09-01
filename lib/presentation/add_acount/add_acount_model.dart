import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddAcountModel extends ChangeNotifier{

   //TextEditingController nameInputController;
   TextEditingController emailInputController = TextEditingController();
   TextEditingController pwdInputController = TextEditingController();

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

  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'パスワードは8文字以上で入力してください';
    } else {
      return null;
    }
  }

  Future addAcount() async{
    
    try{
       final currentUser = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: emailInputController.text, password: pwdInputController.text);

      //await Firestore.instance
      //.collection(currentUser.user.uid)
      /*
      .add({
      "title": "タップしてタイトルを入力できます",
       "uid": currentUser.user.uid,
       "email": emailInputController.text,

      });*/
      return currentUser.user.uid;
    }catch(error){
      return null;
    }
      
    
  }
}