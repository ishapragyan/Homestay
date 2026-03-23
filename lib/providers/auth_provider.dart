import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? user;

  Future<void> signIn(String email, String password) async {
    user = await _authService.signIn(email, password);
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    user = await _authService.signUp(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    user = null;
    notifyListeners();
  }

  void loadCurrentUser() {
    user = _authService.getCurrentUser();
    notifyListeners();
  }

  Future<void> updateUserProfile(String newName) async {
    try {
      // Update Firebase Auth display name
      await user?.updateDisplayName(newName);

      // Reload user to get the latest data
      await user?.reload();
      user = _authService.getCurrentUser();

      // Optional: If you store user data in Firestore, update it here too
      // await _db.collection('users').doc(_user!.uid).update({'name': newName});

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

}