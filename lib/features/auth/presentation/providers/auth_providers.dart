import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:partners_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:partners_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:partners_app/features/auth/domain/usecases/ensure_user_document_usecase.dart';
import 'package:partners_app/features/auth/domain/usecases/send_password_reset_usecase.dart';
import 'package:partners_app/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:partners_app/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:partners_app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:partners_app/features/auth/domain/usecases/sign_up_with_email_usecase.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';

final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn.instance);

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(ref.watch(firebaseAuthProvider), ref.watch(googleSignInProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider)),
);

final ensureUserDocumentUseCaseProvider = Provider(
  (ref) => EnsureUserDocumentUseCase(ref.watch(profileRepositoryProvider)),
);

final signInWithGoogleUseCaseProvider = Provider(
  (ref) => SignInWithGoogleUseCase(ref.watch(authRepositoryProvider), ref.watch(ensureUserDocumentUseCaseProvider)),
);

final signInWithEmailUseCaseProvider = Provider(
  (ref) => SignInWithEmailUseCase(ref.watch(authRepositoryProvider), ref.watch(ensureUserDocumentUseCaseProvider)),
);

final signUpWithEmailUseCaseProvider = Provider(
  (ref) => SignUpWithEmailUseCase(ref.watch(authRepositoryProvider), ref.watch(ensureUserDocumentUseCaseProvider)),
);

final sendPasswordResetUseCaseProvider = Provider(
  (ref) => SendPasswordResetUseCase(ref.watch(authRepositoryProvider)),
);

final signOutUseCaseProvider = Provider(
  (ref) => SignOutUseCase(ref.watch(authRepositoryProvider)),
);
