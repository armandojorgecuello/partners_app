import 'package:firebase_auth/firebase_auth.dart';
import 'package:partners_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:partners_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;

  AuthRepositoryImpl(this._remote);

  @override
  Future<User> signInWithGoogle() async {
    final user = await _remote.signInWithGoogle();
    if (user == null) throw Exception('Google sign-in failed');
    return user;
  }

  @override
  Future<User> signInWithEmail({required String email, required String password}) async {
    final user = await _remote.signInWithEmail(email: email, password: password);
    if (user == null) throw Exception('Email sign-in failed');
    return user;
  }

  @override
  Future<User> signUpWithEmail({required String email, required String password}) async {
    final user = await _remote.signUpWithEmail(email: email, password: password);
    if (user == null) throw Exception('Email sign-up failed');
    return user;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) => _remote.sendPasswordResetEmail(email);

  @override
  Future<void> signOut() => _remote.signOut();
}
