import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suapin/presentation/bloc/auth_cubit.dart';
import 'package:suapin/presentation/bloc/auth_state.dart';
import '../pages/home_page.dart';
import '../pages/inbox_page.dart';
import '../pages/disciplinas_page.dart';
import '../pages/materia_detalhes_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _selectTab(int index) {
    if (index == _currentIndex) {
      // pop to first route
      _navigatorKeys[index].currentState?.popUntil((r) => r.isFirst);
    } else {
      debugPrint('Switching tab: $_currentIndex -> $index');
      setState(() => _currentIndex = index);
    }
  }

  Future<bool> _onWillPop() async {
    final NavigatorState currentNavigator =
        _navigatorKeys[_currentIndex].currentState!;
    if (currentNavigator.canPop()) {
      debugPrint('Pop within tab $_currentIndex');
      currentNavigator.pop();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // Adicionamos o BlocListener aqui!
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Se o estado voltar a ser AuthInitial (logout), manda pro login
        if (state is AuthInitial) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F9F9),
          appBar: AppBar(title: const Text("Suapin")),
          drawer: _buildDrawer(context),
          body: IndexedStack(
            index: _currentIndex,
            children: [
              _buildTabNavigator(0, (context) => const HomePage()),
              _buildTabNavigator(1, (context) => const DisciplinasPage()),
              _buildTabNavigator(2, (context) => const InboxPage()),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _selectTab,
            selectedItemColor: const Color(0xFF065F46),
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Disciplinas',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Inbox'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabNavigator(int index, WidgetBuilder pageBuilder) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        // Local routes for each tab (including detalhes)
        if (settings.name == '/detalhes') {
          final args = settings.arguments;
          if (args is DisciplineData) {
            return MaterialPageRoute(
              builder: (ctx) => MateriaDetalhesPage(data: args),
            );
          } else {
            return MaterialPageRoute(builder: (ctx) => const SizedBox.shrink());
          }
        }
        return MaterialPageRoute(builder: pageBuilder, settings: settings);
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF065F46)),
            child: Text(
              'Suapin',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              debugPrint('Drawer: push /settings');
              Navigator.of(context).pushNamed('/settings');
            },
          ),
          // --- BOTÃO DE LOGOUT REFATORADO ---
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Limpamos o token e disparamos o estado AuthInitial
              context.read<AuthCubit>().logout();
            },
          ),
          // -----------------------------------
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Sobre'),
            onTap: () {
              debugPrint('Drawer: show about dialog');
              showAboutDialog(
                context: context,
                applicationName: 'Suapin',
                applicationVersion: '1.0',
              );
            },
          ),
        ],
      ),
    );
  }
}
