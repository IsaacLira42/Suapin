import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suapin/presentation/bloc/auth_cubit.dart';
import 'package:suapin/presentation/bloc/auth_state.dart';
import 'package:suapin/presentation/pages/login_page.dart';

import '../widgets/main_scaffold.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF006D42)),
            ),
          );
        }

        if (state is AuthAuthenticated) {
          return const MainScaffold();
        }

        return const LoginPage();
      },
    );
  }
}
