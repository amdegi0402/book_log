import 'dart:async';

import 'package:book_meter/presentation/add_book/add_book_page.dart';
import 'package:book_meter/presentation/book_list/book_list_models.dart';
import 'package:flutter/material.dart';
import 'package:book_meter/domain/book.dart';
import 'package:provider/provider.dart';
import 'package:book_meter/presentation/logout/logout_page.dart';
import 'package:book_meter/domain/post.dart';
import 'package:book_meter/presentation/bottom_navi/bottom_navi_model.dart';
import 'package:book_meter/presentation/author/author_list_page.dart';
import 'package:book_meter/presentation/author_title/author_book_page.dart';


class BookListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookListModel>(
          //create: (context) => BottomNavigationBarProvider(),
          create: (_) => BookListModel()..fetchBooks(),
          //Provider(create: (_) => BottomNavigationBarProvider()),
        ),
        ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (_) => BottomNavigationBarProvider(),
        ),
       
      ],
      child:Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: 
        
        AppBar(
          title: Text("タイトル"),
          backgroundColor: Colors.blueGrey[300],
          centerTitle: true,
          
          actions: [
            //テストページ
            IconButton(
              icon: Icon(Icons.toys, color: Colors.white),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthorBookPage()),
                ); 
              },
            ),

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

        body: Consumer<BookListModel>(
          builder: (context, model, child){
          
            final books = model.books;
            final listTiles = books
          
              .map((book) => Container(
                padding: EdgeInsets.only(left: 10, right: 10,top: 5),
              
                child: Card(
                  shadowColor: Colors.blueGrey,
                      child: ListTile(
                        leading: Image.network(book.imageURL,width:50),
                        title: Text(book.title, overflow: TextOverflow.ellipsis),
                        subtitle: Text(book.createAt),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async{
                            //編集アイコンタップで編集画面推移
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:(context) => AddBookPage(
                                  book: book,
                                ),
                                fullscreenDialog: true,
                              ),
                            );                  
                            model.fetchBooks();
                          },
                        ),

                        //リストタイトルをタップしてメモ確認画面へ
                        onTap:(){
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: Center(child:Text(book.title)),
                                children: <Widget>[
                                  // コンテンツ領域
                                  SimpleDialogOption(
                                    onPressed: () => Navigator.pop(context),
                                    child: Column(
                                      children: [
                                        Center(child:Text(book.authorName)),
                                        Text(book.memo),
                                      ],
                                    )
                                    //Text(book.memo),
                                    
                                  ),
                                    
                                    
                                ],
                              );
                            },
                          );
                        },

                        //リストタイトル長押しでタイトル削除処理
                        onLongPress: () async{
                          //削除
                          await showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text('${book.title}を削除しますか？'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('OK'),
                                    onPressed: ()async{
                                      Navigator.of(context).pop();

                                      await deleteBook(context, model, book);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      ))))
              .toList();
            return ListView(
              children: listTiles,
            );
          }
        ),

        bottomNavigationBar:Consumer<BottomNavigationBarProvider>(
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
                if(index == 1){
                  //Navigator.of(context).pushNamed("/home");
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AuthorListPage()),
                  );           
                  print("作者ページへ");
                }

              },
              currentIndex:model.currentIndex,
          );
        }
      ),  
      

     ),
    );
  }

  
   
       

 

  Future deleteBook(
    BuildContext context,
    BookListModel model,
    Book book,
  )async{
    try{
      await model.deleteBook(book);
      await model.fetchBooks();
    }catch(e){
      await _showDialog(context, e.toString());
      print(e.toString());
    }
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

  Future<List<Post>> search(String search) async{
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index){
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }
}