import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../main_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

final AuthService authService = AuthService();

Future<void> loginUser() async {

  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  final user = await authService.signIn(email, password);

  if (user != null) {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
    );

  } else {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Login failed")),
    );

  }
}

@override
Widget build(BuildContext context) {

  return Scaffold(
    appBar: AppBar(
      title: const Text("Login"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: loginUser,
            child: const Text("Login"),
          ),

          const SizedBox(height: 10),

          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupScreen(),
                ),
              );
            },
            child: const Text("Create an account"),
          ),

        ],
      ),
    ),
  );
}
}
