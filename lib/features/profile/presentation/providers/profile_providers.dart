import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:partners_app/features/profile/data/datasources/profile_storage_data_source.dart';
import 'package:partners_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:partners_app/features/profile/domain/entities/user_profile.dart';
import 'package:partners_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:partners_app/features/profile/domain/usecases/create_profile_usecase.dart';
import 'package:partners_app/features/profile/domain/usecases/find_partner_by_code_usecase.dart';
import 'package:partners_app/features/profile/domain/usecases/update_cel_number_usecase.dart';
import 'package:partners_app/features/profile/domain/usecases/update_profile_flags_usecase.dart';
import 'package:partners_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:partners_app/features/profile/domain/usecases/upload_profile_image_usecase.dart';

final profileRemoteDataSourceProvider = Provider(
  (ref) => ProfileRemoteDataSource(ref.watch(firestoreProvider)),
);

final profileStorageDataSourceProvider = Provider(
  (ref) => ProfileStorageDataSource(ref.watch(firebaseStorageProvider)),
);

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(
    ref.watch(profileRemoteDataSourceProvider),
    ref.watch(profileStorageDataSourceProvider),
  ),
);

/// Watches any user's profile document — used both for "my profile" and for
/// partner/sender display lookups (replacing the old `userData` /
/// `getPartnerData` duplication in `UsuarioProvider`).
final userProfileProvider = StreamProvider.family<UserProfile, String>(
  (ref, uid) => ref.watch(profileRepositoryProvider).watchProfile(uid),
);

final createProfileUseCaseProvider = Provider(
  (ref) => CreateProfileUseCase(ref.watch(profileRepositoryProvider)),
);

final updateProfileUseCaseProvider = Provider(
  (ref) => UpdateProfileUseCase(ref.watch(profileRepositoryProvider)),
);

final updateProfileFlagsUseCaseProvider = Provider(
  (ref) => UpdateProfileFlagsUseCase(ref.watch(profileRepositoryProvider)),
);

final updateCelNumberUseCaseProvider = Provider(
  (ref) => UpdateCelNumberUseCase(ref.watch(profileRepositoryProvider)),
);

final uploadProfileImageUseCaseProvider = Provider(
  (ref) => UploadProfileImageUseCase(ref.watch(profileRepositoryProvider)),
);

final findPartnerByCodeUseCaseProvider = Provider(
  (ref) => FindPartnerByCodeUseCase(ref.watch(profileRepositoryProvider)),
);
