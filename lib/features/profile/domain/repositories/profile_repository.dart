import 'dart:io';

import 'package:partners_app/features/profile/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Stream<UserProfile> watchProfile(String uid);

  Future<UserProfile> getProfile(String uid);

  Future<bool> profileExists(String uid);

  Future<void> createProfile({
    required String uid,
    required bool allowPush,
    String? name,
    String? email,
    String? preferences,
    String? celNumber,
    String? photoUrl,
    required bool partnerCheck,
    required bool acceptTerms,
  });

  Future<void> updateProfile({
    required String uid,
    String? name,
    String? email,
    String? preferences,
    String? celNumber,
  });

  Future<void> updateProfileFlags({
    required String uid,
    bool? allowPush,
    bool? allowEmail,
    bool? partnerCheck,
    bool? acceptTerms,
  });

  Future<void> updateCelNumber(String uid, String celNumber);

  Future<String?> findUidByUserCode(String code);

  Future<String> uploadProfileImage(String uid, File image);
}
