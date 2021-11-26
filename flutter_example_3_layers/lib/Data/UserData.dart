import 'dart:convert';

import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/Entities/User.dart';
import 'package:flutter_example_3_layers/env.dart';
import 'package:http/http.dart' as http;

class UserData{


  Future<DataResponse> login(String email,String password) async{
    DataResponse dataResponse=new DataResponse();
    try{
      var url = Uri.parse(host+'/api/login');
      final http.Response response =await http.post(url,
          body: {'email': email, 'password': password});

      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);

      if (response.statusCode == 200) {
        var data=item['data'];

        User user=new User();
        user.id=data['id'].toString();
        user.name=data['name'];
        user.email=data['email'];
        user.token=item['token'];

        dataResponse.data=user;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> signup(String name,String email,String password,String passwordConfirm) async{
    DataResponse dataResponse=new DataResponse();

    try{
      var url = Uri.parse(host+'/api/signup');
      final http.Response response =await http.post(url,
          body: {'name': name,'email': email, 'password': password , 'password_confirm': passwordConfirm});

      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        var data=item['data'];

        User user=new User();
        user.id=data['id'].toString();
        user.name=data['name'];
        user.email=data['email'];
        user.token=item['token'];

        dataResponse.data=user;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }

    return dataResponse;
  }

  Future<DataResponse> logout(String _token) async{
    DataResponse dataResponse=new DataResponse();
    try{
      var url = Uri.parse(host+'/api/logout');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+_token },
          body: { });

      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);

      dataResponse.status=response.statusCode == 200;
      dataResponse.message=item['message'];

    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }

    return dataResponse;
  }

}