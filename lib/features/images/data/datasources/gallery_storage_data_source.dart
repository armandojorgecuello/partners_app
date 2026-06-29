import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class GalleryStorageDataSource {
  final FirebaseStorage _storage;

  GalleryStorageDataSource(this._storage);

  Future<String> uploadImage(String uid, File image) async {
    final ref = _storage
        .ref()
        .child('user_gallery_images')
        .child(uid)
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    final snapshot = await ref.putFile(image);
    return snapshot.ref.getDownloadURL();
  }
}
