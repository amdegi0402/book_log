import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_meter/domain/book.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthorBookModel extends ChangeNotifier{
 List<Book> books = [];
 List<Book> a_books = [];
 List<int> num = [];
 String name;
int authorLength= 0;
String str;
//String author ="ここに表示";
bool showName = false;
  
  //特定のフィールドデータ読み込み
  Future authorBooks(String name) async {
    
    final user = await FirebaseAuth.instance.currentUser();
    final docs = await Firestore.instance.collection(user.uid.toString()).getDocuments();
   
    final books = docs.documents.map((doc) => Book(doc)).toList();
    this.books = books;
    int cnt = 0;
    this.name = name;
    
    
    books.forEach((Book item){
      //print("$cnt name$name ${item.authorName}");
      if(name == item.authorName){
        num.add(cnt);
      }
      cnt++;
    });
    num.forEach((n) {
        a_books.add(books[n]);
        //print("a_book==>${a_books[0].authorName}");
    });
    showName = true;
    notifyListeners(); 
  }

  Future deleteBook(Book book) async{
    final user = await FirebaseAuth.instance.currentUser();

    await Firestore.instance
    .collection(user.uid.toString())
    .document(book.documentID)
    .delete();
  }
}