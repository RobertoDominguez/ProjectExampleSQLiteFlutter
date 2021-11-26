import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_3_layers/Business/UserBusiness.dart';
import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/assets/widgets/buttons.dart';
import 'package:flutter_example_3_layers/assets/widgets/dialog.dart';
import 'package:flutter_example_3_layers/assets/widgets/inputs.dart';
import 'package:flutter_example_3_layers/assets/widgets/styles.dart';
import 'package:flutter_example_3_layers/main.dart';

class SignUp extends StatefulWidget{
  const SignUp({Key? key}) : super(key: key);
  @override
  __SignUpState createState(){
    return __SignUpState();
  }
}

class __SignUpState extends State<SignUp> {
  UserBuiness userBuiness = new UserBuiness();

  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPass = TextEditingController();
  final controllerPassConfirm = TextEditingController();
  String name = "";
  String email = "";
  String pass = "";
  String passConfirm = "";
  String image = "";


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controllerName.addListener(() {
      name = controllerName.text;
    });
    controllerEmail.addListener(() {
      email = controllerEmail.text;
    });
    controllerPass.addListener(() {
      pass = controllerPass.text;
    });
    controllerPassConfirm.addListener(() {
      passConfirm = controllerPassConfirm.text;
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
                SizedBox(height: 20.0),
                CustomInputField(
                    Icon(Icons.lock, color: Colors.white), "NOMBRE",
                    controllerName, false),
                SizedBox(height: 20.0),
                CustomInputField(
                    Icon(Icons.person, color: Colors.white), "E-MAIL",
                    controllerEmail, false),
                SizedBox(height: 20.0),
                CustomInputField(
                    Icon(Icons.lock, color: Colors.white), "CONTRASEÑA",
                    controllerPass, true),
                SizedBox(height: 20.0),
                CustomInputField(Icon(Icons.lock, color: Colors.white),
                    "CONFIRMACION DE CONTRASEÑA", controllerPassConfirm, true),
                SizedBox(height: 20.0),
                buttonPrimary(context, "REGISTRARSE", signup),
                Text('o si ya tienes cuenta',),
                SizedBox(height: 20.0),
                buttonSeccondary(context, "INICIAR SESION", login)
              ],
            ),
          )
      );
  }

  Future<void> signup() async{
    showLoadingIndicator(context,'Registrando usuario');
    DataResponse dataResponse=await userBuiness.signup(name,email,pass,passConfirm);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context,memosAllRoute());
      }else{
        showAlertDialog(context, "Error al crear usuario", dataResponse.message);
      }
    });
  }

  Future<void> login() async{
    Navigator.pushReplacementNamed(context, loginRoute());
  }


}