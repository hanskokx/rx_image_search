import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rx_image_search/classes/image_result.dart';
import 'package:rx_image_search/widgets/download_image_button.dart';

class ImageDetailView extends StatelessWidget {
  final ImageResult imageResult;
  const ImageDetailView({
    Key? key,
    required this.imageResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              return CircularProgressIndicator(value: progress.progress);
            },
          ),
        ],
      ),
      actions: <Widget>[
        DownloadImageButton(imageResult: imageResult),
      ],
    );
  }
}
