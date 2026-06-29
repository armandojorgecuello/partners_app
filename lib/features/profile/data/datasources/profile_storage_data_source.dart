import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ProfileStorageDataSource {
  final FirebaseStorage _storage;

  ProfileStorageDataSource(this._storage);

  Future<String> uploadProfileImage(String uid, File image) async {
    final ref = _storage.ref().child('user_profile_image').child('$uid.jpg');
    final snapshot = await ref.putFile(image);
    return snapshot.ref.getDownloadURL();
  }
}
