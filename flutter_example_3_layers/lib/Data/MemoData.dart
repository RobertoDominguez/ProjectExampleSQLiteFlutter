import 'dart:convert';

import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/Entities/Memo.dart';
import 'package:flutter_example_3_layers/env.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'DB.dart';

class MemoData{

  Future<DataResponse> index(String userId) async{
    DataResponse dataResponse=new DataResponse();

    try {
      Database dataBase=await DB.openDB();
      List<Map> data=await dataBase.rawQuery("SELECT * FROM MEMO WHERE USER_ID=?", [userId]);

      List<Memo> items=List.generate(0, (index) => new Memo());
      data.forEach((element) {
        Memo memo=new Memo();
        memo.id=element['ID'].toString();
        memo.title=element['TITLE'];
        memo.content=element['CONTENT'];
        memo.userId=element['USER_ID'].toString();
        items.add(memo);
      });

      dataResponse.data=items;
      dataResponse.status=true;
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> store(Memo _memo) async{
    DataResponse dataResponse=new DataResponse();
    try {
      Database dataBase=await DB.openDB();

      if (_memo.title!='' && _memo.content!='') {
        await dataBase.insert("MEMO", {"title":_memo.title,"content":_memo.content,"user_id":_memo.userId});

        List<Map> data=await dataBase.rawQuery("SELECT * FROM MEMO ORDER BY ID DESC LIMIT 1");
        print(data[0].toString());
        Memo memo=new Memo();
        memo.id=data[0]['ID'].toString();
        memo.title=data[0]['TITLE'];
        memo.content=data[0]['CONTENT'];
        memo.userId=data[0]['USER_ID'].toString();

        dataResponse.data=memo;
        dataResponse.status=true;
      }
      dataResponse.message="Error al crear nota, nota vacia!";
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> show(String id) async{
    DataResponse dataResponse=new DataResponse();

    try {
      Database dataBase=await DB.openDB();

      List<Map> data=await dataBase.rawQuery("SELECT * FROM MEMO WHERE ID=?",[id]);
      print(data[0].toString());
      Memo memo=new Memo();
      memo.id=data[0]['ID'].toString();
      memo.title=data[0]['TITLE'];
      memo.content=data[0]['CONTENT'];
      memo.userId=data[0]['USER_ID'].toString();

      dataResponse.data=memo;
      dataResponse.status=true;
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> update(Memo _memo) async{
    DataResponse dataResponse=new DataResponse();
    try {
      Database dataBase=await DB.openDB();

      if (_memo.title!='' && _memo.content!='') {
        await dataBase.update("MEMO", _memo.toMap(),where: "ID=?",whereArgs: [_memo.id]);

        List<Map> data=await dataBase.rawQuery("SELECT * FROM MEMO ORDER BY ID DESC LIMIT 1");
        print(data[0].toString());
        Memo memo=new Memo();
        memo.id=data[0]['ID'].toString();
        memo.title=data[0]['TITLE'];
        memo.content=data[0]['CONTENT'];
        memo.userId=data[0]['USER_ID'].toString();

        dataResponse.data=memo;
        dataResponse.status=true;
      }
      dataResponse.message="Error al actualizar, nota vacia!";
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> delete(String id) async{
    DataResponse dataResponse=new DataResponse();
    try {
      Database dataBase=await DB.openDB();
      await dataBase.delete("MEMO", where: "ID=?",whereArgs: [id]);

      dataResponse.message="Se ha eliminado con exito";
      dataResponse.status=true;
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }

    return dataResponse;
  }

}
