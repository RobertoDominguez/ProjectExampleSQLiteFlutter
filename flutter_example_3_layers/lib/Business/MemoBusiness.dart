import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/Data/MemoData.dart';
import 'package:flutter_example_3_layers/Entities/Memo.dart';
import 'package:flutter_example_3_layers/Session/UserSession.dart';

class MemoBusiness{
  MemoData memoData=new MemoData();

  Future<DataResponse> index() async{
    List<Memo> items=List.generate(0, (index) => new Memo());
    DataResponse dataResponse=await memoData.index(UserSession.user.id);
    items=dataResponse.data;
    return dataResponse;
  }

  Future<DataResponse> store(String title,String content) async{
    Memo memo=new Memo();
    memo.title=title;
    memo.content=content;
    memo.userId=UserSession.user.id;
    DataResponse dataResponse=await memoData.store(memo);
    return dataResponse;
  }

  Future<DataResponse> update(Memo memo) async{
    DataResponse dataResponse=await memoData.update(memo);
    return dataResponse;
  }

  Future<DataResponse> delete(String id) async{
    return await memoData.delete(id);
  }


}