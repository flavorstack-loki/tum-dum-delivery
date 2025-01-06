import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:image_picker/image_picker.dart' as ip;
import 'package:path_provider/path_provider.dart';

import '../services/message_service.dart';

enum MediaSource { camera, gallery }

class MediaUtils {
  static String getExtension(String name) =>
      name.substring(name.lastIndexOf('.'));
  static Future<List<String>?> selectMultipleImage() async {
    List<ip.XFile> pickedImagesList = [];
    try {
      var dir = await getApplicationDocumentsDirectory();

      final imageList =
          await ip.ImagePicker().pickMultiImage(maxWidth: 800, maxHeight: 600);
      for (final element in imageList) {
        final res = await FlutterImageCompress.compressAndGetFile(
          element.path,
          "${dir.absolute.path}${element.path.substring(element.path.lastIndexOf('/'))}",
          minHeight: 800,
          minWidth: 600,
          quality: 80,
        );
        if (res != null) {
          pickedImagesList.add(res);
        }
      }
    } on PlatformException catch (e) {
      MessageService.showErrorMessage(
          "There was some error while uploading images.Please try again.");
      print(e.message);
    } catch (e) {
      MessageService.showErrorMessage(
          "There was some error while uploading images.Please try again.");
      print((e as CompressError).message);
    }
    pickedImagesList = pickedImagesList.length > 6
        ? pickedImagesList.sublist(0, 6)
        : pickedImagesList;

    return pickedImagesList.map((e) => e.path).toList();
  }

  static Future<File?> pickMedia(MediaSource imageSource) async {
    try {
      XFile? imageFile;

      switch (imageSource) {
        case MediaSource.camera:
          imageFile =
              (await ip.ImagePicker().pickImage(source: ip.ImageSource.camera));
          break;
        case MediaSource.gallery:
          imageFile =
              await ip.ImagePicker().pickImage(source: ip.ImageSource.gallery);
          break;
      }

      if (imageFile != null) {
        var dir = await getApplicationDocumentsDirectory();

        final res = await FlutterImageCompress.compressAndGetFile(
            imageFile.path,
            "${dir.absolute.path}${imageFile.path.substring(imageFile.path.lastIndexOf('/'))}",
            minHeight: 800,
            minWidth: 600,
            quality: 80);
        if (res != null) return File(res.path);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
