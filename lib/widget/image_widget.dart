import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({required this.link, super.key});
  final String link;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.of(context)
      //     .pushNamed(RouteGenerator.imageViewScreen, arguments: link),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 3)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
              imageUrl: link,
              height: 350,
              width: double.maxFinite,
              fit: BoxFit.cover,
              errorWidget: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.error)),
              progressIndicatorBuilder: (c, w, progress) {
                return const SizedBox(
                    height: 300,
                    width: 300,
                    child: CupertinoActivityIndicator());
              }),
        ),
      ),
    );
  }
}
