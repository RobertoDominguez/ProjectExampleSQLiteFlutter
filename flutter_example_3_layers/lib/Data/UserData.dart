import 'dart:convert';

import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/Entities/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'DB.dart';


class UserData{


   Future<DataResponse> login(String email,String password) async{
    DataResponse dataResponse=new DataResponse();
    try{
      Database dataBase=await DB.openDB();
      List<Map> data=await dataBase.rawQuery("SELECT * FROM USER  WHERE EMAIL=? AND PASSWORD=? ORDER BY ID DESC LIMIT 1",[email,password]);
      if (data.length>0){

        print(data[0].toString());
        User user=new User();
        user.id=data[0]['ID'].toString();
        user.name=data[0]['NAME'];
        user.email=data[0]['EMAIL'];

        dataResponse.data=user;
        dataResponse.status=true;
      }else{
        dataResponse.message="Error, credenciales no validas";
      }
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> signup(String name,String email,String password) async{
    DataResponse dataResponse=new DataResponse();

    try{
      Database dataBase=await DB.openDB();

      List<Map> validateEmail=await dataBase.rawQuery("SELECT * FROM USER WHERE EMAIL=? ",[email]);
      print(validateEmail);
      if (validateEmail.isEmpty){
        if (name!='' && email!='' && password!='') {
          await dataBase.insert("USER", {"name":name,"email":email,"password":password});

          List<Map> data=await dataBase.rawQuery("SELECT * FROM USER ORDER BY ID DESC LIMIT 1");
          print(data[0].toString());
          User user=new User();
          user.id=data[0]['ID'].toString();
          user.name=data[0]['NAME'];
          user.email=data[0]['EMAIL'];

          dataResponse.data=user;
          dataResponse.status=true;
        }else{
          dataResponse.message="Error al crear, falta algun campo";
        }
      }else{
        dataResponse.message="Error al crear, el email ya existe";
      }

    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }

    return dataResponse;
  }

  Future<DataResponse> logout() async{
    DataResponse dataResponse=new DataResponse();
    dataResponse.status=true;
    return dataResponse;
  }

}