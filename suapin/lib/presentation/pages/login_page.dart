import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            debugPrint('Navigator.pushReplacementNamed: /home');
            Navigator.of(context).pushReplacementNamed('/home');
          },
          child: const Text('Entrar (vai para /home)'),
        ),
      ),
    );
  }
}
