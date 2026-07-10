import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suapin/presentation/bloc/auth_cubit.dart';
import 'package:suapin/presentation/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _matriculaController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible =
      false; // Este é um estado puramente visual, pode ficar no setState.

  static const Color _primaryGreen = Color(0xFF006D42);
  static const Color _lightGreenBg = Color(0xFFE8F5E9);

  @override
  void dispose() {
    _matriculaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final matricula = _matriculaController.text.trim();
      final password = _passwordController.text;

      // Chama a regra de negócio do Cubit, tirando a responsabilidade da UI
      context.read<AuthCubit>().login(matricula, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: _primaryGreen)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              // BlocConsumer escuta o estado para navegar/mostrar erros, e constrói a UI (loading)
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login realizado com sucesso!'),
                        backgroundColor: _primaryGreen,
                      ),
                    );
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is AuthLoading;

                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ... MANTENHA O LOGO E O TÍTULO AQUI ...
                        TextFormField(
                          controller: _matriculaController,
                          enabled: !isLoading,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Matrícula',
                            prefixIcon: Icon(
                              Icons.badge_outlined,
                              color: _primaryGreen,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Insira sua matrícula' : null,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _passwordController,
                          enabled: !isLoading,
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
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Insira sua senha' : null,
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: FilledButton(
                            onPressed: isLoading ? null : _submitForm,
                            style: FilledButton.styleFrom(
                              backgroundColor: _primaryGreen,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Entrar',
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
