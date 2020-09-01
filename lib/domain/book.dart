import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Book{
  String authorName;
  String documentID;
  String title;
  String imageURL;
  String memo;
  var create;
  String createAt;
  var format;
  String test;
  String name;

  Book(DocumentSnapshot doc){
    
    initializeDateFormatting('ja');
    documentID = doc.documentID;
    title = doc['title'];
    imageURL = doc['imageURL'];
    memo = doc['memo'];

    authorName = doc['authorName'];
    //firestoreから日付データを読み込み
    create = doc['createAt'].toDate(); //dart日付型に変換
    format = DateFormat.yMMMd('ja');//日付のみ取得する型作成
    createAt = format.format(create).toString();//日付データに適用
  }
}