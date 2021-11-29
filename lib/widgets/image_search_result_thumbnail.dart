import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rx_image_search/classes/image_result.dart';
import 'package:shimmer/shimmer.dart';

class ImageSearchResultThumbnail extends StatelessWidget {
  final ImageResult imageResult;
  final Function(BuildContext context, ImageResult imageResult) onTap;
  const ImageSearchResultThumbnail({
    Key? key,
    required this.imageResult,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String thumbnailUrl = imageResult.thumbnail;

    return GestureDetector(
      onTap: () => onTap(context, imageResult),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Hero(
          tag: imageResult.position,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: thumbnailUrl,
            progressIndicatorBuilder: (
              BuildContext context,
              String url,
              DownloadProgress progress,
            ) {
              return Shimmer.fromColors(
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.white,
                ),
                baseColor: Colors.black12,
                highlightColor: Colors.white,
              );
            },
            errorWidget: (context, url, error) => Column(
              children: [
                Icon(
                  Icons.cloud_off_outlined,
                  color: Theme.of(context).errorColor.withOpacity(0.5),
                  size: 64.0,
                ),
                Text(
                  'Check connection',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
