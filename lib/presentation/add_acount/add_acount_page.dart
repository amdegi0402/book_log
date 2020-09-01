//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_meter/presentation/add_acount/add_acount_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_meter/presentation/book_list/book_list_page.dart';
//import 'package:book_meter/auth/auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart' ;
import 'package:book_meter/presentation/add_book/add_book_page.dart';

class AddAcountPage extends StatelessWidget{
  
  void showFlush(BuildContext context){
     Flushbar(
        message: "無効なメールアドレスです",
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context); 
      //Navigator.of(context).pop();                            
  }
 

  @override
  Widget build(BuildContext context){
    final _formKey = GlobalKey<FormState>();

    return ChangeNotifierProvider<AddAcountModel>(
     create: (_) => AddAcountModel(),
     child: Scaffold(
       backgroundColor:Colors.blueGrey[50],
       /*appBar: AppBar(
         title: Text('新規登録'),
       ),*/
       body: Consumer<AddAcountModel>(
         builder: (context, model, child){
           final Size size = MediaQuery.of(context).size;
           return SingleChildScrollView(
             child: Container(
               
               padding:EdgeInsets.only(top: size.height*0.3),
            
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text("メールアドレスとパスワードを設定してください",style:TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(height: 24.0),

                    TextFormField(
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        labelText: 'Email', hintText: "test@example.com"
                      ),
                      controller: model.emailInputController,
                      keyboardType: TextInputType.emailAddress,
                      validator: model.emailValidator,
                      //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                    ),
                    const SizedBox(height: 24.0),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      controller: model.pwdInputController,
                      obscureText: true,
                      validator: model.pwdValidator,
                      //validator: (value) => value.isEmpty ? 'pwd can\'t be empty' : null,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                 
                    RaisedButton(
                      onPressed: () async{
                        if (_formKey.currentState.validate()) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                              title: Text('よろしいですか？'),
                              
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: ()async{

                                    final uid = await model.addAcount();
                                    if(uid != null){
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) => AddBookPage()),
                                      );
                                  
                                    }else{
                                      Navigator.of(context).pop();
                                      showFlush(context);
                                    }
                                  },
                                ),
                                FlatButton(
                                  child: Text('キャンセル'),
                                  onPressed: (){
                                    showFlush(context);
                                    //Navigator.of(context).pop();
                                  },
                                ),
                               
                              ],
                            );
                          });
                        }
                      },
                      child: Text('アカウント作成'),
                    ),
                  ],
                )
              )
            )
           );
         }   
       )
     )
    );
  }
}