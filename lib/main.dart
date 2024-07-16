import 'package:flutter/material.dart';
import 'package:login/page/Home_page.dart';
import 'package:login/page/login_page.dart';
import 'package:login/page/registrer_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}
