//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_meter/domain/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';



class AddBookModel extends ChangeNotifier{
  String bookTitle = '';
  String bookMemo = '';
  String bookAuthorName = '';
  File imageFile;
  bool isLoading = false;

  startLoading(){
    isLoading = true;
    notifyListeners();
  }

  endLoading(){
    isLoading = false;
    notifyListeners();
  }

  setImage(File imageFile){
    this.imageFile = imageFile;
    notifyListeners();
  }

  //更新ボタンを押したあとの処理
  Future updateBook(Book book)async{
    //_uploadImage関数を使って画像のURLを取得
    final imageURL = await _uploadImage();
    //firebase初期化
    final user = await FirebaseAuth.instance.currentUser();
   
    final document = Firestore.instance.collection(user.uid.toString()).document(book.documentID);
     //final document = Firestore.instance.collection('books').document(book.documentID);
     
    await document.updateData(
      {
        
        'title': bookTitle != "" ? bookTitle : book.title,
        'memo': bookMemo != "" ? bookMemo : book.memo,
        'updateAt': Timestamp.now(),
        'imageURL': imageURL != null ? imageURL : book.imageURL,
        'authorName': bookAuthorName != "" ? bookAuthorName : book.authorName,
      },
    );
  }

  Future<String> _uploadImage() async{
    if(imageFile == null){
     //imageFileがnullの場合はnullを返す
      return null;
    }
    //imageFileに画像が入っていればstorageへ追加
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('books').child(bookTitle);
    final snapshot = await ref
      .putFile(
        imageFile,
      )
      .onComplete;
    //storageに登録した画像URLをダウンロードして値を返す
      final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }


//端末内のギャラリーを開き選択した画像ファイルを返す処理
/*
  Future getImages() async{
    final picker = ImagePicker();//画像選択プラグイン
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    return imageFile;
  }
*/

  Future addBookToFirebase() async{
    final user = await FirebaseAuth.instance.currentUser();
    final imageURL = await _uploadImage();
    if(bookTitle.isEmpty){
      throw('タイトルを入力してください');
    }
    
    Firestore.instance.collection(user.uid.toString()).add(
    {
      'title': bookTitle,
      'memo': bookMemo,
      'createAt': Timestamp.now(),
      'imageURL' : imageURL,
      'authorName' : bookAuthorName,
    }
    );
  }

}