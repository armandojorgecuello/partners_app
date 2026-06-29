import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/profile/data/models/user_profile_model.dart';

class ProfileRemoteDataSource {
  final FirebaseFirestore _firestore;

  ProfileRemoteDataSource(this._firestore);

  CollectionReference get _users => _firestore.collection('users');

  CollectionReference get _userCodes => _firestore.collection('usercodes');

  Stream<UserProfileModel> watchProfile(String uid) {
    return _users.doc(uid).snapshots().map(UserProfileModel.fromSnapshot);
  }

  Future<UserProfileModel> getProfile(String uid) async {
    return UserProfileModel.fromSnapshot(await _users.doc(uid).get());
  }

  Future<bool> profileExists(String uid) async {
    final doc = await _users.doc(uid).get();
    return doc.exists;
  }

  Future<void> createProfile(String uid, String usercode, Map<String, dynamic> data) async {
    await _users.doc(uid).set(data);
    await _userCodes.doc(usercode).set({'uid': uid});
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> data) {
    return _users.doc(uid).update(data);
  }

  Future<bool> userCodeExists(String code) async {
    final doc = await _userCodes.doc(code).get();
    return doc.exists;
  }

  Future<String?> findUidByUserCode(String code) async {
    final doc = await _userCodes.doc(code).get();
    if (!doc.exists) return null;
    return (doc.data() as Map<String, dynamic>?)?['uid'] as String?;
  }
}
