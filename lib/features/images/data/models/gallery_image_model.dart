import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partners_app/features/images/domain/entities/gallery_image.dart';

class GalleryImageModel {
  final String photoUrl;
  final Timestamp? dateTime;

  const GalleryImageModel({required this.photoUrl, this.dateTime});

  factory GalleryImageModel.fromJson(Map<String, dynamic> json) =>
      GalleryImageModel(photoUrl: json['photo_url'] ?? '', dateTime: json['date_time']);

  GalleryImage toEntity() => GalleryImage(photoUrl: photoUrl, dateTime: dateTime?.toDate());
}
