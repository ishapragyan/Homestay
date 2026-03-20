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

  try {
    print("Testing Firestore connection...");
    await FirebaseFirestore.instance.collection('test_connection').add({
      'status': 'Connection Successful!',
      'timestamp': DateTime.now().toString(),
    });
    print("✅ FIRESTORE IS WORKING! Check your Firebase Console.");
  } catch (e) {
    print("❌ FIRESTORE ERROR: $e");
  }

  runApp( MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [

          ChangeNotifierProvider( create: (_) { final authProvider = AuthProvider();
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
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    ));
  }
}