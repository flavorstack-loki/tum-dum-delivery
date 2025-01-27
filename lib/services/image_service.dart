import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tumdum_delivery_app/services/message_service.dart';
import 'package:tumdum_delivery_app/util/media_utils.dart';

import '../widget/media_source.dart';

class ImageService {
  static Future<String?> selectImage(BuildContext context) async {
    final MediaSource? imageSource = await (showModalBottomSheet(
      context: context,
      builder: (ctx) => MediaSourceWidget(ctx),
    )) as MediaSource?;
    if (imageSource == null) return null;
    try {
      context.loaderOverlay.show();
      final temp = await MediaUtils.pickMedia(imageSource);
      context.loaderOverlay.hide();
      return temp?.path;
    } catch (e) {
      context.loaderOverlay.hide();
      print(e.toString());
      MessageService.showErrorMessage("Image uploading failed!");
    }
    return null;
  }

  static Future<List<String>?> selectMultipleImage(BuildContext context) async {
    final MediaSource? imageSource = await (showModalBottomSheet(
      context: context,
      builder: (ctx) => MediaSourceWidget(ctx),
    )) as MediaSource?;
    if (imageSource == null) return null;
    try {
      context.loaderOverlay.show();
      final temp = await MediaUtils.selectMultipleImage();
      context.loaderOverlay.hide();
      return temp;
    } catch (e) {
      context.loaderOverlay.hide();
      MessageService.showErrorMessage("Image uploading failed!");
    }
    return null;
  }
}
