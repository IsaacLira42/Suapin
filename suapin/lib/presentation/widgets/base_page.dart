import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const BasePage({super.key, required this.child, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
