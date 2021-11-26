import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_3_layers/Business/MemoBusiness.dart';
import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/assets/widgets/buttons.dart';
import 'package:flutter_example_3_layers/assets/widgets/dialog.dart';
import 'package:flutter_example_3_layers/assets/widgets/styles.dart';

import '../../main.dart';

class CreateMemo extends StatefulWidget{
  const CreateMemo({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return __CreateMemoState();
  }

}

class __CreateMemoState extends State<CreateMemo>{
  MemoBusiness memoBusiness=new MemoBusiness();

  final controllerTitle = TextEditingController();
  final controllerContent = TextEditingController();
  String title = "";
  String content = "";

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    controllerTitle.addListener(() {
      title = controllerTitle.text;
    });
    controllerContent.addListener(() {
      content = controllerContent.text;
    });
    return Scaffold(
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
                cardMemo(context),
                SizedBox(height: 10,),
                buttonSeccondary(context, "Guardar", storeMemo),
                SizedBox(height: 10,),
                buttonPrimary(context, "Cancelar", cancel),
              ],
            ),
          )
      );
  }

  Widget cardMemo(BuildContext context){
    return Card(
      color: Colors.yellow.shade400,
      child:Container(
        height: 500,
        color: Colors.yellow.shade400,
        child: Column(
          children: [
            SizedBox(height: 5,),
            Center(
              child: Text('Titulo', style: TextStyle(fontSize: 21,color: Style1().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextField(
              controller: controllerTitle,
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('Contenido', style: TextStyle(fontSize: 21,color: Style1().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 16,
              maxLines: 16,
              controller: controllerContent,
            ),
          ],
        ),
        margin: EdgeInsets.all(10),
      ),
      elevation: 8,
      margin: EdgeInsets.all(5),
    );
  }

  Future<void> storeMemo() async{
    showLoadingIndicator(context,'Creando nota...');

    DataResponse dataResponse=await memoBusiness.store(title, content);

    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context,memosAllRoute());
      }else{
        showAlertDialog(context, "Error al guardar nota", dataResponse.message);
      }
    });
  }

  Future<void> cancel() async{
    Navigator.of(context).pop();
  }


  
}