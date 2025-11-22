import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_tv/utils/api_string.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    this.imageUrl,
    this.fit,
    this.width,
    this.height,
  });
  final String? imageUrl;
  final BoxFit? fit;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return imageUrl == null || imageUrl == ''
        ? errorWidget()
        : CachedNetworkImage(
            width: width,
            height: height,

            imageUrl: ApiString.imageUrl + imageUrl!,
            progressIndicatorBuilder: (context, url, progress) {
              return const Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(fontSize: 10, color: Colors.red),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return errorWidget();
            },
            fit: fit ?? BoxFit.contain,
          );
  }

  Widget errorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.image, color: Colors.pink),
        Text(
          'Image not available',
          style: TextStyle(fontSize: 10, color: kMainColor),
        ),
      ],
    );
  }
}
