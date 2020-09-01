
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_meter/test/fb_test_model.dart';



class FbTestPage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<FbTestModel>(
      create: (_)=> FbTestModel(),
        child: Scaffold(
        body: Consumer<FbTestModel>(
          builder: (context, model, child){
            return Container(
              color: Colors.blueGrey[100],
              child:Center(
                child:Padding(
                  padding: EdgeInsets.only(top: size.height*0.45),
                  child: Column(
                    children: [
                      Text(model.author),
                      RaisedButton(
                        child: Text('btton'),
                        onPressed:(){   
                          //model.getData("1gpw6NVNRz2kAQNdjlJh","authorName");
                          //model.getDocuments();
                        }
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      )
    );
  }
}
