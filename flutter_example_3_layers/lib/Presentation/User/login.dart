import 'package:flutter/material.dart';
import 'package:flutter_example_3_layers/Business/UserBusiness.dart';
import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/assets/widgets/buttons.dart';
import 'package:flutter_example_3_layers/assets/widgets/dialog.dart';
import 'package:flutter_example_3_layers/assets/widgets/inputs.dart';
import 'package:flutter_example_3_layers/assets/widgets/styles.dart';
import 'package:flutter_example_3_layers/env.dart';
import 'package:flutter_example_3_layers/main.dart';


class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __LoginState();
  }

}

class __LoginState extends State<Login>{
  UserBuiness userBuiness=new UserBuiness();

  final controllerEmail = TextEditingController();
  final controllerPass = TextEditingController();
  String email = "";
  String pass = "";

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    controllerEmail.addListener(() {
      email = controllerEmail.text;
    });
    controllerPass.addListener(() {
      pass = controllerPass.text;
    });
    return Scaffold(
      backgroundColor: Style1().backgroundColor(),
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
                Image.asset(assetURL()+"logo.png", alignment: Alignment.center, height: 300, width: 300,),
                CustomInputField( Icon(Icons.person, color: Colors.white), "E-MAIL", controllerEmail, false),
                SizedBox(height: 20.0),
                CustomInputField( Icon(Icons.lock, color: Colors.white), "Contraseña", controllerPass, true),
                SizedBox(height: 20.0),
                buttonPrimary(context, "INICIAR SESION", login),
                SizedBox(height: 20.0),
                buttonSeccondary(context, "REGISTRARME", signUp),

              ],
            ),
          )
      );
  }

  Future<void> login() async{
    showLoadingIndicator(context,'Iniciando sesion');

    DataResponse dataResponse=await userBuiness.login(email,pass);
    //DataResponse dataResponse=await userBuiness.login('user@example.com','123123123');
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context,memosAllRoute());
      }else{
        showAlertDialog(context, "Error al iniciar Sesion", dataResponse.message);
      }
    });
  }

  Future<void> signUp() async{
    Navigator.pushReplacementNamed(context, signupRoute());
  }




}



