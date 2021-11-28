import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rx_image_search/classes/image_result.dart';

class ImageSearchResultThumbnail extends StatelessWidget {
  final ImageResult? imageResult;
  const ImageSearchResultThumbnail({Key? key, this.imageResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String thumbnailUrl = imageResult?.thumbnail ?? '';
    return Card(
      elevation: 2,
      child: CachedNetworkImage(
        imageUrl: thumbnailUrl,
      ),
    );
  }
}
