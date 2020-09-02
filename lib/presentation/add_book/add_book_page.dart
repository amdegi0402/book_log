import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_meter/presentation/add_book/add_book_model.dart';
import 'package:book_meter/presentation/book_list/book_list_page.dart';
import 'package:book_meter/domain/book.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:provider/provider.dart';
import 'dart:io';


class AddBookPage extends StatelessWidget{
  AddBookPage({this.book});
  final Book book;
  final picker = ImagePicker();
 
 bool _cnt = false;
  @override
  Widget build(BuildContext context){
 
    final bool isUpdate = book != null;
    final titleTextEditingController = TextEditingController();
    final memoTextEditingController = TextEditingController();
    final authorTextEditingController = TextEditingController();
    

    if(isUpdate){
      titleTextEditingController.text = book.title;
      memoTextEditingController.text = book.memo;
      authorTextEditingController.text = book.authorName;
    }

    return ChangeNotifierProvider<AddBookModel>(
     create: (_) => AddBookModel(),
    child: Stack(
      children: [
         Scaffold(
           resizeToAvoidBottomPadding: false,
           resizeToAvoidBottomInset: true,
           backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            title: Text(isUpdate ? '本を編集' : '本を追加'),
            backgroundColor: Colors.blueGrey[300],
            centerTitle: true,
          ),
          body: Consumer<AddBookModel>(
            builder: (context, model, child){
     
              return SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.only(top:8.0, left:8.0, right:8.0),
                child: Column(
                  children: [
                    //画像エリアをタップしたときの処理
                    InkWell(
                        onTap:()async{
                          //端末内のギャラリーを開き選択した画像ファイルを返す
                            final pickedFile = await picker.getImage(
                              source: ImageSource.gallery);
                            // model.callUserData(book);//
                            try{
                              //imageFileに選択した画像をセット
                              model.setImage(File(pickedFile.path));
                              _cnt = true;
                            }catch(error){
                              //Navigator.of(context).pop();
                            }
                        },
                       
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child:
                        isUpdate == false && _cnt == false ? Container(color: Colors.grey) 
                        : model.imageFile != null ? Image.file(model.imageFile) 
                        : Image.network(book.imageURL),

                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:10)),
                    Card(color: Colors.white,
                      child:TextField(
                      controller: titleTextEditingController,
                       decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'タイトル',
                    ),
                      onChanged: (text){
                        model.bookTitle = text;
                      },
                    ),
                    ),
                    
                    Padding(padding: EdgeInsets.only(top:10)),
                    Card(
                      color: Colors.white,
                      
                      child:TextField(
                        controller: authorTextEditingController,
                        cursorRadius: Radius.circular(50),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '作者名',
                          //labelText: 'メモ',
                          //contentPadding: const EdgeInsets.symmetric(vertical: 30.0),
                        ),
                        onChanged: (text){
                          if(text == ""){
                            model.bookAuthorName = "不明";
                          }else{
                            model.bookAuthorName = text;
                          }
                          
                          
                        },
                        maxLines: null,
                      ),
                    ),
                    
                    Padding(padding: EdgeInsets.only(top:10)),
                    Card(
                      color: Colors.white,
                      
                      child:TextField(
                        controller: memoTextEditingController,
                        cursorRadius: Radius.circular(50),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'メモ',
                        ),
                        onChanged: (text){
                          model.bookMemo = text;
                          
                        },
                        maxLines: null,
                      ),
                    ),

                    
                   
                    
                    Padding(padding: EdgeInsets.only(top:10)),
                    RaisedButton(                  
                      child: Text(isUpdate ? '更新' : '追加'),
                      onPressed: () async{
                        model.startLoading();

                        if(isUpdate){
                          await updateBook(model, context);
                        }else{
                          await addBook(model, context);
                        }

                        model.endLoading();
                      },
                    ),
                  ],
                ),

              ),
              );  
            },
          ),
        ), 

        Consumer<AddBookModel>(builder: (context, model, child){
          return model.isLoading
            ? Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
            : SizedBox();
        }),
      ],
    )
    
    );
  }


  Future addBook(AddBookModel model, BuildContext context) async{
    try{
      await model.addBookToFirebase();
      
      await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('保存しました'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: (){
                  //Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BookListPage()),
                  );
                },
              ),
            ],
          );
        },
      );
      
      Navigator.push(
        context,
        //MaterialPageRoute(builder: (context) => BookListPage()),
        MaterialPageRoute(builder: (context) => BookListPage()),
      ); 
      
    }catch(e){
      print("error");
      
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
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

  Future updateBook(AddBookModel model, BuildContext context)async{
    try{
      await model.updateBook(book);
      await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('更新しました'),
            actions: <Widget>[
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
      Navigator.of(context).pop();
    }catch(e){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
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
}