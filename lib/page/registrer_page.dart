import 'package:flutter/material.dart';
import 'package:login/page/Home_page.dart';
import 'package:login/page/login_page.dart';
import 'database_helper.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(249, 43, 0, 255),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Registro".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                _textFieldFirstName(),
                SizedBox(height: 15.0),
                _textFieldLastName(),
                SizedBox(height: 15.0),
                _textFieldEmail(),
                SizedBox(height: 15.0),
                _textFieldPassword(),
                SizedBox(height: 15.0),
                _textFieldConfirmPassword(),
                SizedBox(height: 20.0),
                _buttonSignUp(),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, LoginPage.id);
                  },
                  child: Text(
                    'Ya tengo una cuenta. Iniciar sesión.',
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
 Widget _textFieldFirstName() {
    return _textFieldGeneral(
      controller: _firstNameController,
      labelText: 'Nombre',
      hintText: 'Montse',
      icon: Icons.person_outline,
      keyboardType: TextInputType.name,
    );
  }

  Widget _textFieldLastName() {
    return _textFieldGeneral(
      controller: _lastNameController,
      labelText: 'Apellidos',
      hintText: 'Pérez',
      icon: Icons.person_outline,
      keyboardType: TextInputType.name,
    );
  }

  Widget _textFieldEmail() {
    return _textFieldGeneral(
      controller: _emailController,
      labelText: 'Correo electrónico',
      hintText: 'mon1@gmail.com',
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

  Widget _textFieldConfirmPassword() {
    return _textFieldGeneral(
      controller: _confirmPasswordController,
      labelText: 'Confirmar contraseña',
      hintText: '',
      keyboardType: TextInputType.visiblePassword,
      icon: Icons.lock_outline_rounded,
      obscureText: true,
    );
  }

  Widget _buttonSignUp() {
  return ElevatedButton(
    child: Text('Registrarme'),
    onPressed: () async {
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;

      // Validar campos vacíos
      if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Por favor, completa todos los campos'),
        ));
        return;
      }

      // Validar que las contraseñas coincidan
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Las contraseñas no coinciden'),
        ));
        return;
      }

      await DatabaseHelper().insertUser(firstName, lastName, email, password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Usuario registrado correctamente'),
      ));
    },
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
        // Navegar a la pantalla de inicio
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
  // Métodos para los campos de texto
  // _textFieldFirstName(), _textFieldLastName(), _textFieldEmail(), 
  // _textFieldPassword(), _textFieldConfirmPassword() y 
  // _buttonSignUp() se mantienen iguales que ante
