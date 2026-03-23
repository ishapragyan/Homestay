import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../main_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  Future<void> signupUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    // Luxury loading state
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final user = await authService.signUp(email, password);

    if (!mounted) return;
    Navigator.pop(context); // Remove loading indicator

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup failed. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background and colors are pulled from the Global Theme in main.dart
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("CREATE ACCOUNT"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Subtle Gold Accent
              Container(
                width: 40,
                height: 2,
                color: const Color(0xFFFFCD8C),
              ),
              const SizedBox(height: 20),

              const Text(
                "Join HomeStay",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF002366),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Experience luxury in every stay.",
                style: TextStyle(color: Colors.black38, fontSize: 14),
              ),

              const SizedBox(height: 50),

              // Email Input
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

              // Password Input
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Create Password",
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),

              const SizedBox(height: 40),

              // Signup Button
              ElevatedButton(
                onPressed: signupUser,
                child: const Text("REGISTER"),
              ),

              const SizedBox(height: 30),

              const Text(
                "By joining, you agree to our terms and conditions.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black26, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}