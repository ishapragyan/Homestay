import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key}); // Added key for best practice

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body:Center( // Wrapped in Center for better alignment
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const CircleAvatar(
            radius: 40,
            child: Icon(Icons.person),
          ),
          const SizedBox(height: 20),
          Text(user?.email ?? "No Email"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await authProvider.signOut();

              // Ensure the widget is still mounted before navigating
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }
            },
            child: const Text("Logout"),
          ),
        ],
      ),
      )

    );
  }
}