import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/features/images/domain/repositories/gallery_repository.dart';
import 'package:partners_app/features/images/domain/usecases/upload_gallery_image_usecase.dart';

class _MockGalleryRepository extends Mock implements GalleryRepository {}

void main() {
  late _MockGalleryRepository repository;
  late UploadGalleryImageUseCase useCase;
  final image = File('photo.jpg');

  setUpAll(() {
    registerFallbackValue(File(''));
  });

  setUp(() {
    repository = _MockGalleryRepository();
    useCase = UploadGalleryImageUseCase(repository);
  });

  test('uploads the image and returns Ok on success', () async {
    when(() => repository.uploadImage(any(), any())).thenAnswer((_) async {});

    final result = await useCase(UploadGalleryImageParams(uid: 'uid-1', image: image));

    expect(result, isA<Ok<void>>());
    verify(() => repository.uploadImage('uid-1', image)).called(1);
  });

  test('maps a repository failure to a ServerFailure', () async {
    when(() => repository.uploadImage(any(), any())).thenThrow(Exception('upload failed'));

    final result = await useCase(UploadGalleryImageParams(uid: 'uid-1', image: image));

    expect(result, isA<Err<void>>());
    expect((result as Err<void>).failure, isA<ServerFailure>());
  });
}
