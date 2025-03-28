import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String logoPath;

  const LoadingScreen({super.key, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedRotation(
          duration: const Duration(seconds: 2),
          turns: 1,
          child: Image.asset(
            logoPath,
            width: 120,
            height: 120,
          ),
        ),
      ),
    );
  }
}

