import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_screen.dart';
import 'services/auth_service.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  final AuthService authService = AuthService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final user = authService.getCurrentUser();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: user == null
          ? LoginScreen()
          : MainScreen(),

    );
  }
}