import 'package:book_meter/presentation/book_list/book_list_page.dart';
import 'package:book_meter/auth/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:book_meter/presentation/reset_pass/reset_password_page.dart';

class AuthPage extends StatelessWidget{
  void showFlush(BuildContext context){
     Flushbar(
        message: "IDもしくはPassWordが一致していません",
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
    return ChangeNotifierProvider<AuthModel>(
        create: (_) => AuthModel(),
        child: Scaffold(
          backgroundColor:Colors.blueGrey[50],
          /*
          appBar: AppBar(
            title:Text('Book Meter'),
          ),
          */
          body: Consumer<AuthModel>(builder: (context, model, child){
            return Container(
              //padding:EdgeInsets.only(top: size.height*0.3),
             child: Center(
             child: Form(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 24.0),

                      TextFormField(
                        controller: model.emailInputController,
                        decoration: const InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 24.0),

                      TextFormField(
                        controller: model.passwordInputController,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Password',
                        ),
                        obscureText: true, //PWを隠す
                      ),
                      const SizedBox(height: 24.0),

                      Center(
                        child: new RaisedButton(
                          child: const Text('Login'),
                          onPressed: () async{
                            var email = model.emailInputController.text;
                            var password = model.passwordInputController.text;
                     
                            //final AuthResult result = await model.signIn(email, password);
                            final result = await model.signIn(email, password);

                            if(result == null){
                              showFlush(context);
                            }else{
                              /*
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BookListPage()),
                              );
                              */
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => BookListPage()),
                              );

                            }
                          },
                        ),

                        
                      ),
                      FlatButton(
                        textColor: Colors.blue,
                        child: Text('パスワードが不明な場合'),
                        onPressed:(){   
                         /*
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPassPage()),
                          );
                        */
                           Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ResetPassPage()),
                              );               
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ));
          })
          
        )
      );

  }
}