import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _matriculaController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Definição da paleta de cores institucional
  static const Color _primaryGreen = Color(0xFF006D42);
  static const Color _lightGreenBg = Color(
    0xFFE8F5E9,
  ); // Tom claro para feedback/fundo

  @override
  void dispose() {
    _matriculaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final matricula = _matriculaController.text.trim();
      // Lógica de autenticação integrada com a API aqui
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Autenticando matrícula: $matricula...'),
          backgroundColor: _primaryGreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Sobrescreve o tema local para garantir a paleta verde e branca nesta tela
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryGreen,
          primary: _primaryGreen,
          surface: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _primaryGreen, width: 2.0),
          ),
          labelStyle: TextStyle(color: _primaryGreen),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white, // Fundo predominantemente branco
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ícone ou Logo Acadêmica customizada em Verde
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: _lightGreenBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.school_outlined,
                        size: 48,
                        color: _primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Título do App
                    const Text(
                      'Suapin',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: _primaryGreen,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Campo de Matrícula
                    TextFormField(
                      controller: _matriculaController,
                      keyboardType: TextInputType.number,
                      // Permite apenas números no teclado
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Matrícula',
                        prefixIcon: Icon(
                          Icons.badge_outlined,
                          color: _primaryGreen,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, insira sua matrícula';
                        }
                        if (value.length < 4) {
                          return 'Insira uma matrícula válida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Campo de Senha
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: _primaryGreen,
                        ),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _primaryGreen,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha';
                        }
                        if (value.length < 6) {
                          return 'A senha deve conter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Botão de Entrar (Verde com texto Branco)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        onPressed: _submitForm,
                        style: FilledButton.styleFrom(
                          backgroundColor: _primaryGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
