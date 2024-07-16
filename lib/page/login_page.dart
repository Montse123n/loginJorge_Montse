import 'package:flutter/material.dart';
import 'package:login/page/Home_page.dart';  // Asegúrate de que el nombre del archivo sea correcto
import 'package:login/page/registrer_page.dart';
import 'database_helper.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(250, 255, 0, 0),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Iniciar Sesión".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                _textFieldEmail(),
                SizedBox(height: 15.0),
                _textFieldPassword(),
                SizedBox(height: 20.0),
                _buttonLogin(),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RegisterPage.id);
                  },
                  child: Text(
                    '¿No tienes una cuenta? Regístrate.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return _textFieldGeneral(
      controller: _emailController,
      labelText: 'Correo electrónico',
      hintText: 'ejemplo@gmail.com',
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
    );
  }

  Widget _textFieldPassword() {
    return _textFieldGeneral(
      controller: _passwordController,
      labelText: 'Contraseña',
      hintText: '',
      keyboardType: TextInputType.visiblePassword,
      icon: Icons.lock_outline_rounded,
      obscureText: true,
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      child: Text('Iniciar Sesión'),
      onPressed: () async {
        final email = _emailController.text;
        final password = _passwordController.text;
        final user = await DatabaseHelper().getUser(email, password);
        if (user != null) {
          Navigator.pushReplacementNamed(context, HomePage.id);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Correo o contraseña incorrectos'),
          ));
        }
      },
    );
  }
}

class _textFieldGeneral extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final IconData icon;
  final bool obscureText;

  const _textFieldGeneral({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}

