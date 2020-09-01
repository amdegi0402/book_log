
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:book_meter/domain/book.dart';

class FbTestModel extends ChangeNotifier{
  int authorLength = 0;
  String author ="ここに表示";
  List<Book> books = [];
  List<String> authorName = [];
  
  
  //特定のフィールドデータ読み込み
  Future<String> getData() async {
  List<String> str = [];
  final user = await FirebaseAuth.instance.currentUser();
    
    final docs = await Firestore.instance.collection(user.uid.toString()).getDocuments();
    final books = docs.documents.map((doc) => Book(doc)).toList();
    this.books = books;
    authorLength = books.length;

    for(int i = 0; i < authorLength; i++){
      str.add(books[i].authorName.toString());
      
    }
    
    for(int i = 0; i < str.length - 1; i++){
      for(int k = 0; k <str.length; k++){
        if(str[i] == str[k]){
          
          str.remove(str[k]);
          str.join(',');
          print(str.length.toString());
        }
      }
    }
    //author = str.length.toString();
    notifyListeners();
    
  }
}