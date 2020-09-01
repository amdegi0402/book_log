import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_meter/domain/book.dart';
import 'package:firebase_auth/firebase_auth.dart';


class BookListModel extends ChangeNotifier{
  List<Book> books = [];
  int currentIndex = 0;

  Future fetchBooks() async{

    final user = await FirebaseAuth.instance.currentUser();
    
    final docs = await Firestore.instance.collection(user.uid.toString()).getDocuments();
    final books = docs.documents.map((doc) => Book(doc)).toList();
    this.books = books;
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