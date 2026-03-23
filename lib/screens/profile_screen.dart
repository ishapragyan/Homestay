import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'auth/login_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
        backgroundColor: const Color(0xFFF8FAF9),
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // --- Profile Header ---
            // --- Updated Profile Header ---
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF002366).withOpacity(0.2), width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        spreadRadius: 4,
                      )
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xFF002366),
                    child: Icon(Icons.person, size: 55, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),

                // The Display Name (Premium Styling)
                Text(
                  user?.displayName ?? "Add your name",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800, // Extra bold for premium feel
                    letterSpacing: -0.5,       // Tighter letter spacing looks modern
                    color: Color(0xFF1A1A1A),  // Deep near-black
                  ),
                ),

                const SizedBox(height: 4),

                // The Email (Sub-text)
                Text(
                  user?.email ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // --- Account Sections ---
            _buildSectionTitle("Account Settings"),
            _buildProfileOption(
              icon: Icons.edit_outlined,
              title: "Edit Profile",
              onTap: () { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              ); },
            ),

            _buildProfileOption(
              icon: Icons.feedback_outlined,
              title: "Feedback",
              onTap: () { /* Show Feedback Form */ },
            ),

            const SizedBox(height: 20),
            _buildSectionTitle("Support"),
            _buildProfileOption(
              icon: Icons.help_outline,
              title: "Help Center",
              onTap: () {},
            ),

            const SizedBox(height: 30),
            // --- Logout Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.1),
                    foregroundColor: Colors.redAccent,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    await authProvider.signOut();
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    }
                  },
                  child: const Text("Logout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for section titles
  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.1),
      ),
    );
  }

  // Helper widget for list options
  Widget _buildProfileOption({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Color(0xFFB8860B).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: Color(0xFFB8860B)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}