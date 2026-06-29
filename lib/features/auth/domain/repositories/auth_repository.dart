import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User> signInWithGoogle();

  Future<User> signInWithEmail({required String email, required String password});

  Future<User> signUpWithEmail({required String email, required String password});

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();
}
