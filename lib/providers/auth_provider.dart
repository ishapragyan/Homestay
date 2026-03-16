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
}