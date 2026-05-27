import 'package:flutter/material.dart';
import '../pages/inbox_page.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const BasePage({super.key, required this.child, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F9), // Fundo
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: child,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF065F46),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 3 && currentIndex != 3) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const InboxPage()));
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Disciplinas'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Inbox'),
        ],
      ),
    );
  }
}
