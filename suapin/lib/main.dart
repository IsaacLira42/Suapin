import 'package:flutter/material.dart';
import 'package:suapin/presentation/pages/login_page.dart';
import 'package:suapin/presentation/widgets/main_scaffold.dart';
import 'package:suapin/presentation/pages/settings_page.dart';
import 'package:suapin/presentation/pages/about_page.dart';
import 'package:suapin/presentation/pages/materia_detalhes_page.dart';
import 'package:suapin/presentation/pages/disciplinas_page.dart';
import 'package:suapin/presentation/pages/disciplinas_page.dart' as dp;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suapin',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const MainScaffold(),
        '/settings': (context) => const SettingsPage(),
        '/sobre': (context) => const AboutPage(),
        '/disciplinas': (context) => const DisciplinasPage(),
        '/detalhes': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          if (args is dp.DisciplineData) {
            return MateriaDetalhesPage(data: args);
          }
          return const MateriaDetalhesPage();
        },
      },
    );
  }
}
