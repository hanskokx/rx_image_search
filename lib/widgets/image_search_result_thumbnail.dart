import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rx_image_search/classes/image_result.dart';
import 'package:rx_image_search/widgets/download_image_button.dart';

Future<void> _enlargeImage(
  BuildContext context,
  ImageResult imageResult,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(imageResult.title),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: imageResult.original,
              errorWidget: (context, url, error) => Icon(
                Icons.cloud_off_outlined,
                color: Theme.of(context).errorColor,
                size: 64.0,
              ),
              progressIndicatorBuilder: (
                BuildContext context,
                String url,
                DownloadProgress progress,
              ) {
                return SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(value: progress.progress),
                );
              },
            ),
          ],
        ),
        actions: <Widget>[
          DownloadImageButton(imageResult: imageResult),
        ],
      );
    },
  );
}

class ImageSearchResultThumbnail extends StatelessWidget {
  final ImageResult imageResult;
  const ImageSearchResultThumbnail({Key? key, required this.imageResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String thumbnailUrl = imageResult.thumbnail;
    return GestureDetector(
      onTap: () => _enlargeImage(context, imageResult),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedNetworkImage(
            imageUrl: thumbnailUrl,
            progressIndicatorBuilder: (
              BuildContext context,
              String url,
              DownloadProgress progress,
            ) {
              return SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(value: progress.progress),
              );
            },
          ),
        ),
      ),
    );
  }
}
