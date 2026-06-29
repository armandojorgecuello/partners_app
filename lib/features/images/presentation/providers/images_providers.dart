import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/features/images/data/datasources/gallery_remote_data_source.dart';
import 'package:partners_app/features/images/data/datasources/gallery_storage_data_source.dart';
import 'package:partners_app/features/images/data/repositories/gallery_repository_impl.dart';
import 'package:partners_app/features/images/domain/entities/gallery_image.dart';
import 'package:partners_app/features/images/domain/repositories/gallery_repository.dart';
import 'package:partners_app/features/images/domain/usecases/upload_gallery_image_usecase.dart';

final galleryRemoteDataSourceProvider = Provider(
  (ref) => GalleryRemoteDataSource(ref.watch(firestoreProvider)),
);

final galleryStorageDataSourceProvider = Provider(
  (ref) => GalleryStorageDataSource(ref.watch(firebaseStorageProvider)),
);

final galleryRepositoryProvider = Provider<GalleryRepository>(
  (ref) => GalleryRepositoryImpl(
    ref.watch(galleryRemoteDataSourceProvider),
    ref.watch(galleryStorageDataSourceProvider),
  ),
);

final galleryImagesProvider = StreamProvider.family<List<GalleryImage>, String>(
  (ref, uid) => ref.watch(galleryRepositoryProvider).watchImages(uid),
);

final uploadGalleryImageUseCaseProvider = Provider(
  (ref) => UploadGalleryImageUseCase(ref.watch(galleryRepositoryProvider)),
);
