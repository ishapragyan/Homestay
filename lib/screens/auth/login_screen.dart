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


    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final user = await authService.signIn(email, password);


    if (!mounted) return;
    Navigator.pop(context);

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login failed. Please check your credentials."),
          backgroundColor: Color(0xFF002366),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),

              Container(
                width: 50,
                height: 2,
                color: const Color(0xFFFFCD8C),
              ),
              const SizedBox(height: 20),

              Text(
                "HomeStays",
                style: TextStyle(
                  fontFamily: 'HomeStayFont',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Exclusive Guest Access",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),

              const SizedBox(height: 60),

              // Email Field
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                enableSuggestions: true,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 20),

              // Password Field
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),

              const SizedBox(height: 40),

              // Login Button (Uses global elevatedButtonTheme)
              ElevatedButton(
                onPressed: loginUser,
                child: const Text("SIGN IN"),
              ),

              const SizedBox(height: 25),

              // Signup Redirect
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "New to HomeStay? ",
                    style: TextStyle(color: Colors.black45),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupScreen()),
                      );
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Color(0xFF002366),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}