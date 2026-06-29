import 'dart:io';
import 'dart:math';

import 'package:partners_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:partners_app/features/profile/data/datasources/profile_storage_data_source.dart';
import 'package:partners_app/features/profile/domain/entities/user_profile.dart';
import 'package:partners_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remote;
  final ProfileStorageDataSource _storage;

  ProfileRepositoryImpl(this._remote, this._storage);

  static const _codeChars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  Future<String> _generateUniqueUserCode() async {
    final random = Random.secure();
    while (true) {
      final code = List.generate(6, (_) => _codeChars[random.nextInt(_codeChars.length)]).join();
      if (!await _remote.userCodeExists(code)) return code;
    }
  }

  @override
  Stream<UserProfile> watchProfile(String uid) {
    return _remote.watchProfile(uid).map((model) => model.toEntity());
  }

  @override
  Future<UserProfile> getProfile(String uid) async {
    return (await _remote.getProfile(uid)).toEntity();
  }

  @override
  Future<bool> profileExists(String uid) => _remote.profileExists(uid);

  @override
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
  }) async {
    final usercode = await _generateUniqueUserCode();
    await _remote.createProfile(uid, usercode, {
      'name': name,
      'email': email,
      'preferences': preferences,
      'cel_number': celNumber,
      'uid': uid,
      'photo_url': photoUrl,
      'partner_check': partnerCheck,
      'accept_terms': acceptTerms,
      'allow_push': allowPush,
      'allow_emails': true,
      'lang': '',
      'first_launch': true,
      'usercode': usercode,
    });
  }

  @override
  Future<void> updateProfile({
    required String uid,
    String? name,
    String? email,
    String? preferences,
    String? celNumber,
  }) {
    return _remote.updateProfile(uid, {
      'name': name,
      'email': email,
      'preferences': preferences,
      'cel_number': celNumber,
      'first_launch': false,
    });
  }

  @override
  Future<void> updateProfileFlags({
    required String uid,
    bool? allowPush,
    bool? allowEmail,
    bool? partnerCheck,
    bool? acceptTerms,
  }) {
    final data = <String, dynamic>{};
    if (allowPush != null) data['allow_push'] = allowPush;
    if (allowEmail != null) data['allow_emails'] = allowEmail;
    if (partnerCheck != null) data['partner_check'] = partnerCheck;
    if (acceptTerms != null) data['accept_terms'] = acceptTerms;
    return _remote.updateProfile(uid, data);
  }

  @override
  Future<void> updateCelNumber(String uid, String celNumber) {
    return _remote.updateProfile(uid, {'cel_number': celNumber});
  }

  @override
  Future<String?> findUidByUserCode(String code) => _remote.findUidByUserCode(code);

  @override
  Future<String> uploadProfileImage(String uid, File image) async {
    final url = await _storage.uploadProfileImage(uid, image);
    await _remote.updateProfile(uid, {'photo_url': url});
    return url;
  }
}
