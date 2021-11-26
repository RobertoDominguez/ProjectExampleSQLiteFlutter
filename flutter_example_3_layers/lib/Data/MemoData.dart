import 'dart:convert';

import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/Entities/Memo.dart';
import 'package:flutter_example_3_layers/env.dart';
import 'package:http/http.dart' as http;

class MemoData{

  Future<DataResponse> index(String token) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/memos');
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<Memo> items=List.generate(0, (index) => new Memo());
        List list=item['data'];

        list.forEach((element) {
          Memo memo=new Memo();
          memo.id=element['id'].toString();
          memo.title=element['title'];
          memo.content=element['content'];
          items.add(memo);
        });

        dataResponse.data=items;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> store(String token,Memo memo) async{
    DataResponse dataResponse=new DataResponse();
    try {
      var url = Uri.parse(host+'/api/memos');
      final http.Response response =await http.post(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
        body: { 'title': memo.title,'content':memo.content}
      );

      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {

        var data=item['data'];

        Memo memo=new Memo();
        memo.id =data['id'].toString();
        memo.title=data['title'];
        memo.content=data['content'];

        dataResponse.data=memo;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> show(String token,String id) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/memos/'+id);
      final http.Response response =await http.get(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {

        var data=item['data'];

        Memo memo=new Memo();
        memo.id =data['id'].toString();
        memo.title=data['title'];
        memo.content=data['content'];

        dataResponse.data=memo;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> update(String token,Memo memo) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/memos/'+memo.id);
      final http.Response response =await http.put(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token ,'Content-Type':'application/x-www-form-urlencoded'},
          encoding: Encoding.getByName('utf-8'),
          body: {'title':memo.title,'content':memo.content}
      );

      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        var data=item['data'];

        Memo memo=new Memo();
        memo.id =data['id'].toString();
        memo.title=data['title'];
        memo.content=data['content'];

        dataResponse.data=memo;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> delete(String token,String id) async{
    DataResponse dataResponse=new DataResponse();
    try {
      var url = Uri.parse(host+'/api/memos/'+id);
      final http.Response response =await http.delete(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

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
