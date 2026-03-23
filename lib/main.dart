import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/hotel_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Your existing Firestore connection test logic
  try {
    await FirebaseFirestore.instance.collection('test_connection').add({
      'status': 'Connection Successful!',
      'timestamp': DateTime.now().toString(),
    });
    print("✅ FIRESTORE IS WORKING!");
  } catch (e) {
    print("❌ FIRESTORE ERROR: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // New Modern Boutique Palette
  static const Color offWhite = Color(0xFFF8FAF9);
  static const Color deepNavy = Color(0xFF002366);
  static const Color softGold = Color(0xFFFFCD8C);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final authProvider = AuthProvider();
            authProvider.loadCurrentUser();
            return authProvider;
          },
        ),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => HotelProvider()),
      ],
      child: MaterialApp(
        title: 'HomeStay',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: offWhite,

          // Primary Color for Icons and Accents
          primaryColor: deepNavy,
          colorScheme: ColorScheme.fromSeed(
            seedColor: deepNavy,
            primary: deepNavy,
            secondary: softGold,
            surface: offWhite,
          ),

          // Luxury AppBar Styling
          appBarTheme: const AppBarTheme(
            backgroundColor: offWhite,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: deepNavy),
            titleTextStyle: TextStyle(
              color: deepNavy,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),

          // Clean Input Fields
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            prefixIconColor: deepNavy,
            labelStyle: const TextStyle(color: Colors.black45),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: deepNavy.withOpacity(0.05)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: softGold, width: 2),
            ),
          ),

          // Modern Button Style
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: deepNavy,
              foregroundColor: Colors.white,
              elevation: 0,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),

          // Text Theme for Navy contrast
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: deepNavy),
            bodyMedium: TextStyle(color: deepNavy),
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}