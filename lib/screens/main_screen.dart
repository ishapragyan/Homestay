import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  // Your existing screen list[cite: 4]
  final List<Widget> screens = [
    const HomePage(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[currentIndex], //[cite: 4]

      // PREMIUM FLOATING NAVIGATION BAR
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 25), // Floating effect
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF002366).withOpacity(0.15), // Soft Emerald shadow
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BottomNavigationBar(
            currentIndex: currentIndex, //[cite: 4]
            onTap: (index) {
              setState(() {
                currentIndex = index; //[cite: 4]
              });
            },
            backgroundColor: Colors.white,
            elevation: 0, // Handled by the container shadow
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: false,

            // COLOR THEME
            selectedItemColor: const Color(0xFFB8860B), // GOLD when active
            unselectedItemColor: const Color(0xFF002366), // Royal Navy in general
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 0.5,
            ),

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}