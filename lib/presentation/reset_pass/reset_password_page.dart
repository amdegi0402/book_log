import 'package:book_meter/presentation/add_book/add_book_page.dart';
import 'package:book_meter/presentation/book_list/book_list_models.dart';
import 'package:flutter/material.dart';
import 'package:book_meter/domain/book.dart';
//import 'package:flutter/semantics.dart';
import 'package:provider/provider.dart';
import 'package:book_meter/presentation/reset_pass/reset_password_model.dart';
import 'package:flushbar/flushbar.dart';
import 'package:book_meter/presentation/main/main.dart';

class ResetPassPage extends StatelessWidget{
  

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<ResetPassModel>(
     create: (_) => ResetPassModel(),
     child: Scaffold(
       appBar: AppBar(
         title: Text("リセット パスワード"),
       ),
       

       body: Consumer<ResetPassModel>(
         
         builder: (context, model, child){
           final formGlobalKey = GlobalKey();
          return Center(
             child: Form(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 24.0),

                      TextFormField(

                        decoration: InputDecoration(
                        labelText: 'Email', hintText: "leborn.james@gmail.com"
                        ),
                        controller: model.emailInputController,
                        keyboardType: TextInputType.emailAddress,
                        validator: model.emailValidator,
                      ),
                      const SizedBox(height: 24.0),

                      Center(
                        child: FlatButton(
                           child: const Text('送信'),
                          onPressed: () async{
                              model.email = model.emailInputController.text;
                              String _result = await model.sendPasswordResetEmail(model.email);

                              //成功時
                              if(_result == 'success'){
                                //Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyApp()),
                                );              
                              }else if(_result == 'ERROR_INVALID_EMAIL'){
                                Flushbar(
                                  message: "無効なメールアドレスです",
                                  backgroundColor: Colors.red,
                                  margin: EdgeInsets.all(8),
                                  borderRadius: 8,
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              }else if(_result == 'ERROR_USER_NOT_FOUND'){
                                Flushbar(
                                  message: "メールアドレスが登録されていません",
                                  backgroundColor: Colors.red,
                                  margin: EdgeInsets.all(8),
                                  borderRadius: 8,
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              }else{
                                Flushbar(
                                  message: "メールの送信に失敗しました",
                                  backgroundColor: Colors.red,
                                  margin: EdgeInsets.all(8),
                                  borderRadius: 8,
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              }
                            
                          },
                        )
                      )
                    ]
                  )
                )
              )
            );
         }
       ),
     ) 
    );
  }
}