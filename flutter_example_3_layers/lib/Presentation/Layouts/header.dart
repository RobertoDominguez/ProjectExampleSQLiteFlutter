import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_3_layers/Business/UserBusiness.dart';
import 'package:flutter_example_3_layers/Data/DataResponse.dart';
import 'package:flutter_example_3_layers/Session/UserSession.dart';
import 'package:flutter_example_3_layers/assets/widgets/dialog.dart';
import 'package:flutter_example_3_layers/assets/widgets/styles.dart';

import '../../main.dart';

class SideNav extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return __SideNavState();
  }

}

class __SideNavState extends State<SideNav>{

  UserBuiness userBuiness=new UserBuiness();

  List<Widget> listaDeCards=List.generate(0, (index) =>SizedBox(height: 1,));

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Notas de: '+UserSession.user.name,style: TextStyle(fontSize: 21,color: Style1().primaryColor()),),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            cardLogout(context)
          ],
        ),
      ),
    );
  }

  Widget cardLogout(BuildContext context){
    return ListTile(
      title: Text('Cerrar sesion'),
      //leading: Icon(Icons.account_box),
      trailing: Icon(Icons.logout),
      onTap: () async{

        DataResponse dataResponse=await userBuiness.logout();
        setState(() {
          hideOpenDialog(context);
          if (dataResponse.status){
            Navigator.pushNamedAndRemoveUntil(context,loginRoute(), (Route<dynamic> route) => false);
          }else{
            showAlertDialog(context, "Error al cerrar sesion", dataResponse.message);
          }
        });
      },
    );
  }

}

PreferredSizeWidget headerAppBar(BuildContext context){
  return AppBar(
    backgroundColor: Style1().backgroundColor(),
    elevation: 0,
    titleSpacing: 0.0,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          color: Style1().primaryColor(),
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

      ],
    ),
  );
}


Widget searchBar(BuildContext context){
  return Column(
    children: [
      CupertinoSearchTextField(
        backgroundColor: Style1().backgroundColor(),
        onSubmitted: (String text){

        } ,
      ),
      Divider(
        color: Colors.grey.shade400,
      ),
    ],
  );
}


Widget navigationHeader(BuildContext context,String title){
  return Container(
    color: Style1().seccondaryColor(),
    width: MediaQuery.of(context).size.width,
    height: 50,
    child: Row(
      children: [
        SizedBox(width: 20,),
        Icon(Icons.home,color: Style1().primaryColor(),),
        SizedBox(width: 20,),
        Icon(Icons.chevron_right,color: Style1().uiColor(),),
        SizedBox(width: 20,),
        Text(title,style: TextStyle(color: Style1().primaryColor(),fontSize: 20 ),)
      ],
    ),
  );
}
