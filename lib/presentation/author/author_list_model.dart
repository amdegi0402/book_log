import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_meter/domain/book.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthorListModel extends ChangeNotifier{
 List<Book> books = [];
 List<String> a_books = [];
  int authorLength= 0;
  String str;
  String author ="ここに表示";
   bool showName =false;

  //特定のフィールドデータ読み込み
  Future<String> nameList() async {
    List<String> str = [];
    final user = await FirebaseAuth.instance.currentUser();
    final docs = await Firestore.instance.collection(user.uid.toString()).getDocuments();
    final books = docs.documents.map((doc) => Book(doc)).toList();
    this.books = books;
    authorLength = books.length;
    int cnt = 0;
    List<String> a_book = [];
    List<String> aName = [];
    Map<String, int> mapName = new Map<String, int>();
    bool f_name = false;
    

  
    books.forEach((book){
      a_book.add(book.authorName.toString()); //作者名追加
    });

    books.forEach((book) {
      for(int i =0; i < a_books.length; i++){
        if(a_books[i] == book.authorName && f_name == false){
          f_name = true;
        }else if(a_book[i] == book.authorName && f_name == true){
          a_book[i] = "";
        }
      }
      f_name = false;
    });

    a_book.forEach((e) {
      if(e != ""){
        aName.add(e);
      }
    });
    
    


   

   
    print("a_book${a_book} books${books.length}");
    a_books = aName;
    showName = true;
    notifyListeners();
  }
}