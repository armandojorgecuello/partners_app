import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/images/data/models/gallery_image_model.dart';

class GalleryRemoteDataSource {
  final FirebaseFirestore _firestore;

  GalleryRemoteDataSource(this._firestore);

  CollectionReference _imagesCollection(String uid) =>
      _firestore.collection('user_gallery_images').doc(uid).collection('images');

  Stream<List<GalleryImageModel>> watchImages(String uid) {
    return _imagesCollection(uid).orderBy('date_time', descending: true).snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => GalleryImageModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<void> addImage(String uid, String photoUrl) {
    return _imagesCollection(uid).add({'photo_url': photoUrl, 'date_time': Timestamp.now()});
  }
}
