import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Replaces the camera/gallery `showDialog` duplicated in new_task_page.dart,
/// profile_picture.dart and my_images_page.dart.
Future<ImageSource?> showImageSourceDialog(BuildContext context) {
  return showDialog<ImageSource>(
    context: context,
    builder: (context) => SimpleDialog(
      title: const Text('Select image source'),
      children: [
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pop(ImageSource.camera),
          child: const Row(
            children: [Icon(Icons.camera_alt), SizedBox(width: 12), Text('Camera')],
          ),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
          child: const Row(
            children: [Icon(Icons.photo_library), SizedBox(width: 12), Text('Gallery')],
          ),
        ),
      ],
    ),
  );
}
