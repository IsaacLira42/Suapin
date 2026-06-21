import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suapin/data/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _matriculaController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authService = AuthService();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // Definição da paleta de cores institucional
  static const Color _primaryGreen = Color(0xFF006D42);
  static const Color _lightGreenBg = Color(0xFFE8F5E9);

  @override
  void dispose() {
    _matriculaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final matricula = _matriculaController.text.trim();
      final password = _passwordController.text;

      // Realiza a chamada assíncrona para a API externa através do serviço
      final success = await _authService.login(matricula, password);

      // Verifica se o widget continua montado na árvore antes de atualizar o estado ou usar o context
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login realizado com sucesso!'),
            backgroundColor: _primaryGreen,
          ),
        );
        // Avançar para a tela principal
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Falha na autenticação. Verifique os dados.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
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
                      enabled:
                          !_isLoading, // Bloqueia digitação enquanto carrega
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
                      enabled:
                          !_isLoading, // Bloqueia digitação enquanto carrega
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
                          onPressed: _isLoading
                              ? null
                              : () {
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

                    // Botão de Entrar (Reativo ao estado de Loading)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        onPressed: _isLoading
                            ? null
                            : _submitForm, // Previne múltiplos cliques
                        style: FilledButton.styleFrom(
                          backgroundColor: _primaryGreen,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: _primaryGreen.withOpacity(
                            0.6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
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
