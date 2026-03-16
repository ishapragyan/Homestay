import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // SIGN UP
  Future<User?> signUp(String email, String password) async {
    try {
      final credential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // SIGN IN
  Future<User?> signIn(String email, String password) async {
    try {
      final credential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // SIGN OUT
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // CURRENT USER
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // AUTH STATE STREAM
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}