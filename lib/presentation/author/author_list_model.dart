import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_meter/domain/book.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthorListModel extends ChangeNotifier{
 List<Book> books = [];
 List<String> aBooks = [];
  int authorLength= 0;
  String str;
  String author ="ここに表示";
   bool showName =false;

  //特定のフィールドデータ読み込み
  Future<String> nameList() async {
    final user = await FirebaseAuth.instance.currentUser();
    final docs = await Firestore.instance.collection(user.uid.toString()).getDocuments();
    final books = docs.documents.map((doc) => Book(doc)).toList();
    this.books = books;
    authorLength = books.length;
    List<String> a_book = [];
    List<String> aName = [];
    bool fName = false;
    

  
    books.forEach((book){
      a_book.add(book.authorName.toString()); //作者名追加
    });

    books.forEach((book) {
      for(int i =0; i < aBooks.length; i++){
        if(aBooks[i] == book.authorName && fName == false){
          fName = true;
        }else if(a_book[i] == book.authorName && fName == true){
          a_book[i] = "";
        }
      }
      fName = false;
    });

    a_book.forEach((e) {
      if(e != ""){
        aName.add(e);
      }
    });
    
    


   

   
    print("a_book${a_book} books${books.length}");
    aBooks = aName;
    showName = true;
    notifyListeners();
  }
}