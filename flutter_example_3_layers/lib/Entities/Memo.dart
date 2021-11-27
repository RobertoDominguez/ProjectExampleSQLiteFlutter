import 'package:flutter/material.dart';

class Memo{
  String id='';
  String title='';
  String content='';
  String userId='';

  //Memo({required this.id,required this.title,required this.content});
  Map<String,dynamic> toMap(){
    return {'id': this.id , 'title': this.title, 'content': this.content,'user_id':this.userId};
  }

}