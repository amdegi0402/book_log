import 'dart:async';

import 'package:book_meter/presentation/add_book/add_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_meter/presentation/logout/logout_page.dart';
import 'package:book_meter/presentation/book_list/book_list_page.dart';
import 'package:book_meter/presentation/bottom_navi/bottom_navi_model.dart';
import 'package:book_meter/presentation/author/author_list_model.dart';
import 'package:book_meter/presentation/author_title/author_book_page.dart';

class AuthorListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthorListModel>(
          create: (_) => AuthorListModel()..nameList(),
        ),
        ChangeNotifierProvider<BottomNaviAuthorBarProvider>(
          create: (_) => BottomNaviAuthorBarProvider(),
        ),
       
      ],
      child:Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: 
        
        AppBar(
          title: Text("作者名"),
          backgroundColor: Colors.blueGrey[300],
          centerTitle: true,
          
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBookPage()),
                ); 
              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogoutPage()),
                ); 
              },
            ),
          ],      
        ),

        body: Consumer<AuthorListModel>(
          builder: (context, model, child){
            if(model.showName == false) model.nameList();
            final books = model.aBooks;
            final listTiles = books
              .map((book) => Container(
                padding: EdgeInsets.only(left: 10, right: 10,top: 1),
              
                child: Card(
                  shadowColor: Colors.blueGrey,
                      child: ListTile(
                        title: Text(book, overflow: TextOverflow.ellipsis),
                        //リストタイトルをタップしてメモ確認画面へ
                        onTap:(){
                          
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => AuthorBookPage(name: book.toString())),
                          );
                          
                        },
                      ))))
              .toList();
            return ListView(
              children: listTiles,
            );
          }
        ),

        bottomNavigationBar:Consumer<BottomNaviAuthorBarProvider>(
          builder: (_, model, __){
            return BottomNavigationBar(
            items: const<BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                title: Text('タイトル'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                title: Text('作者名'),
              ),
            ],
              //fixedColor: Colors.red,
              selectedItemColor: Colors.blue,
              onTap: (int index){
                model.setCurrentIndex(index);
                if(index == 0){
                  //Navigator.of(context).pushNamed("/home");
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BookListPage()),
                  );           
                }
              },
              currentIndex:model.currentIndex,
          );
        }
      ),  
     ),
    );
  }

  Future _showDialog(
    BuildContext context,
    String title,
  ){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          actions:<Widget>[
            FlatButton(
              child: Text('OK'),
              
              onPressed: (){
                Navigator.of(context).pop();
              },
              
            ),
          ],
        );
      },
    );
  }
}