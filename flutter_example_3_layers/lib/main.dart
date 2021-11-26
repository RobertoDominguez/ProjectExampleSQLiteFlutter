import 'package:flutter/material.dart';
import 'package:flutter_example_3_layers/Presentation/Memo/all.dart';
import 'package:flutter_example_3_layers/Presentation/Memo/create.dart';
import 'package:flutter_example_3_layers/Presentation/Memo/edit.dart';
import 'package:flutter_example_3_layers/Presentation/User/login.dart';

import 'Presentation/User/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: loginRoute(),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login' : (context) => const Login(),
        '/signup' : (context) => const SignUp(),
        '/memos/all' : (context) => const All(),
        '/memos/create' : (context) => const CreateMemo(),
        '/memos/edit' : (context) => const EditMemo()
      },
    );
  }
}


String loginRoute() => '/login';
String signupRoute() => '/signup';
String memosAllRoute() => '/memos/all';
String memosCreateRoute() => '/memos/create';
String memosEditRoute() => '/memos/edit';


//para ejecutar en web con html renderer
////flutter run -d chrome --web-renderer html