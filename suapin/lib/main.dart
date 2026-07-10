import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suapin/data/services/auth_service.dart';
import 'package:suapin/presentation/bloc/auth_cubit.dart';
import 'package:suapin/domain/entities/discipline_data.dart';
import 'package:suapin/presentation/widgets/auth_gate.dart';
import 'package:suapin/presentation/widgets/main_scaffold.dart';
import 'package:suapin/presentation/pages/login_page.dart';
import 'package:suapin/presentation/pages/settings_page.dart';
import 'package:suapin/presentation/pages/about_page.dart';
import 'package:suapin/presentation/pages/materia_detalhes_page.dart';
import 'package:suapin/presentation/pages/disciplinas_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Envolvemos a raiz do app com o MultiBlocProvider
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          // 2. Criamos a instância do AuthCubit injetando o AuthService nele
          create: (context) => AuthCubit(AuthService()),
        ),
      ],
      // 3. O child passa a ser o seu MaterialApp original
      child: MaterialApp(
        title: 'Suapin',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: const AuthGate(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const MainScaffold(),
          '/settings': (context) => const SettingsPage(),
          '/sobre': (context) => const AboutPage(),
          '/disciplinas': (context) => const DisciplinasPage(),
          '/detalhes': (context) {
            final args = ModalRoute.of(context)!.settings.arguments;
            if (args is DisciplineData) {
              return MateriaDetalhesPage(data: args);
            }
            return const MateriaDetalhesPage();
          },
        },
      ),
    );
  }
}
