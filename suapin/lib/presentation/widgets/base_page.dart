import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;

  const BasePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Suapin"), backgroundColor: Color(0xFFECFDF5)),
      body: Padding(padding: const EdgeInsets.all(24.0), child: child),
    );
  }
}
