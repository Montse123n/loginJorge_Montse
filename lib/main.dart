import 'package:flutter/material.dart';
import 'package:login/page/login_page.dart';
import 'package:login/page/home_page.dart';
import 'package:login/page/registrer_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Citas Médicas',
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage(),
        RegisterPage.id: (context) => RegisterPage(),
      },
    );
  }
}

