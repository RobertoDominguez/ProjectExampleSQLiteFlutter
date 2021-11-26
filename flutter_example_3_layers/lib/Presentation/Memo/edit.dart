import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_3_layers/Business/MemoBusiness.dart';
import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/Entities/Memo.dart';
import 'package:flutter_example_3_layers/assets/widgets/buttons.dart';
import 'package:flutter_example_3_layers/assets/widgets/dialog.dart';
import 'package:flutter_example_3_layers/assets/widgets/styles.dart';

import '../../main.dart';

class EditMemoArguments {
  final Memo memo;

  EditMemoArguments(this.memo);
}

class EditMemo extends StatefulWidget{
  const EditMemo({Key? key, }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __EditMemoState();
  }

}

class __EditMemoState extends State<EditMemo>{
  MemoBusiness memoBusiness=new MemoBusiness();

  final controllerTitle = TextEditingController();
  final controllerContent = TextEditingController();
  Memo memo=new Memo();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EditMemoArguments;
    this.memo=args.memo;
    controllerTitle.text=args.memo.title;
    controllerContent.text=args.memo.content;

    controllerTitle.addListener(() {
      memo.title = controllerTitle.text;
    });
    controllerContent.addListener(() {
      memo.content = controllerContent.text;
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
                buttonSeccondary(context, "Guardar", update),
                SizedBox(height: 10,),
                buttonPrimary(context, "Atras", cancel)
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

  Future<void> update() async{
    showLoadingIndicator(context,'Actualizando nota...');

    DataResponse dataResponse=await memoBusiness.update(this.memo);

    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context,memosAllRoute());
      }else{
        showAlertDialog(context, "Error al actualizar nota", dataResponse.message);
      }
    });
  }

  Future<void> cancel() async{
    Navigator.of(context).pop();
  }

}