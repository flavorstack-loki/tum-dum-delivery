import 'package:flutter/material.dart';

import '../util/media_utils.dart';

class MediaSourceWidget extends StatelessWidget {
  const MediaSourceWidget(this.ctx, {super.key});
  final BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        const Text('Choose Source',
            style: TextStyle(
                fontSize: 25,
                //    color: ColorUtil.buttonBgColor,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () => Navigator.of(ctx).pop(MediaSource.camera),
              icon: const Icon(
                Icons.camera_alt,
              ),
              label: const Text(
                'Camera',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            TextButton.icon(
              onPressed: () => Navigator.of(ctx).pop(MediaSource.gallery),
              icon: const Icon(
                Icons.camera,
              ),
              label: const Text(
                'Gallery',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
