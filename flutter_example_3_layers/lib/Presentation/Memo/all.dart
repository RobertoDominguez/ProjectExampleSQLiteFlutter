import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_3_layers/Business/MemoBusiness.dart';
import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/Entities/Memo.dart';
import 'package:flutter_example_3_layers/Presentation/Layouts/header.dart';
import 'package:flutter_example_3_layers/Presentation/Memo/edit.dart';
import 'package:flutter_example_3_layers/assets/widgets/dialog.dart';
import 'package:flutter_example_3_layers/assets/widgets/styles.dart';
import 'package:flutter_example_3_layers/main.dart';

class All extends StatefulWidget{
  const All({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __AllState();
  }

}

class __AllState extends State<All>{

  MemoBusiness memoBusiness=new MemoBusiness();
  List<Widget> listaDeCards=List.generate(0, (index) =>SizedBox(height: 1,));

  @override
  void initState() {
    super.initState();
    loadMemos(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Style1().backgroundColor(),
      appBar: headerAppBar(context),
      drawer: SideNav(),
      floatingActionButton:  FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context,memosCreateRoute());
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.black
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              //appBackground(),
              SingleChildScrollView(
                child: todo(context),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget todo(BuildContext context) {
    return
      SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                //searchBar(context),
                listOfMemos()
              ],
            ),
          )
      );

  }

  void loadMemos(BuildContext context) async{

    await Future.delayed(Duration(milliseconds: 10));
    showLoadingIndicator(context,'');
    DataResponse dataResponse=await memoBusiness.index();
    List<Memo> items=dataResponse.data;
    setState(() {
      hideOpenDialog(context);
      items.forEach((item) {
        var c = cardMemo(context,item);
        listaDeCards.add(c);
      });
    });
  }

  Widget listOfMemos() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listaDeCards.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index) {
          return listaDeCards[index];
        });
  }

  Widget cardMemo(BuildContext context,Memo memo){
    return Card(
      child:Container(
        height: 170,
        color: Colors.yellow.shade400,
        child: Row(
          children: [
            Expanded(
              child:Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        child: ListTile(
                          title: Text(memo.title),
                          subtitle: Text(memo.content),
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, memosEditRoute(),arguments: EditMemoArguments(memo));
                        },
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            color: Style1().primaryColor(),
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushNamed(context, memosEditRoute(),arguments: EditMemoArguments(memo));
                            },
                          ),
                          SizedBox(width: 8,),
                          IconButton(
                            color: Style1().primaryColor(),
                            icon: const Icon(Icons.delete),
                            onPressed: () async{
                              showAlertDialogOptions(context,"Eliminar Nota","¿Estas seguro que deseas eliminar la nota?",
                                      () async{
                                await deleteMemo(memo);
                              });
                            },
                          ),
                          SizedBox(width: 8,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex:8 ,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
    );
  }

  Future<void> deleteMemo(Memo memo) async{
    showLoadingIndicator(context,'Eliminando nota...');
    DataResponse dataResponse=await memoBusiness.delete(memo.id);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context, memosAllRoute());
      }else{
        showAlertDialog(context, "Error al eliminar nota", dataResponse.message);
      }
    });
  }

}

