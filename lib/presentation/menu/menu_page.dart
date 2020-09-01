
import 'package:book_meter/presentation/book_list/book_list_page.dart';
import 'package:flutter/material.dart';
import 'package:book_meter/presentation/add_acount/add_acount_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_meter/auth/auth.dart';
import 'package:book_meter/presentation/reset_pass/reset_password_page.dart';


class MenuPage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Colors.blueGrey[100],
        child:Center(
          child:Padding(
            padding: EdgeInsets.only(top: size.height*0.45),
            child: Column(
              children: [
                RaisedButton(
                  child: Text('ログイン'),
                  onPressed:(){   
                    inputData(context); 
                  }
                ),
                FlatButton(
                  textColor: Colors.blue,
                  child: Text('アカウント作成はこちら'),
                  onPressed:(){   
                    Navigator.push(
                      
                      context,
                      MaterialPageRoute(builder: (context) => AddAcountPage()),
                    );                 
                  }
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

Future inputData(context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final FirebaseUser user = await _auth.currentUser();
      final _uid =  user.uid;
      print("login_uid =_${_uid}");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:(context) => BookListPage(),
          ));
    }catch(e){
        //Navigator.of(context).pushNamed("/AuthPage");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuthPage()),
        );                
    }
  
}
