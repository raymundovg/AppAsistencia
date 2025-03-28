import 'package:FastCHECK/screens/loading_screen.dart';
import 'package:FastCHECK/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoadingScreen(logoPath: 'assets/logo.gif'),
  ));

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
