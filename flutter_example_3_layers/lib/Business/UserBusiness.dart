import 'dart:convert';

import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/Data/UserData.dart';
import 'package:flutter_example_3_layers/Entities/User.dart';
import 'package:flutter_example_3_layers/Session/UserSession.dart';


class UserBuiness{
  UserData userData=new UserData();

  Future<DataResponse> login(String email,String password) async{
    DataResponse response=await this.userData.login(email,password);
    if (response.status){
      User usr=response.data;
      UserSession.setSession(usr);
    }
    return response;
  }

  Future<DataResponse> signup(String name,String email,String password,String passwordConfirm) async{
    DataResponse dataResponse=new DataResponse();

    if (password!=passwordConfirm){
      dataResponse.status=false;
      dataResponse.message='La contraseña y la confirmacion no son iguales';
      return dataResponse;
    }

    dataResponse=await this.userData.signup(name,email,password);
    if (dataResponse.status){
      User usr=dataResponse.data;
      UserSession.setSession(usr);
    }

    return dataResponse;
  }

  Future<DataResponse> logout() async{
    DataResponse dataResponse=await this.userData.logout();
    if (dataResponse.status){
      User usr=new User();
      UserSession.setSession(usr);
    }
    return dataResponse;
  }

}