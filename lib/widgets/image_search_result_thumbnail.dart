import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rx_image_search/classes/image_result.dart';

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
          TextButton(
            child: const Text('Save to gallery'),
            onPressed: () async {
              await _requestPermission(context);
              await _save(imageResult);
            },
          ),
        ],
      );
    },
  );
}

_requestPermission(BuildContext context) async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();

  final info = statuses[Permission.storage].toString();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(info),
  ));
}

_save(ImageResult imageResult) async {
  String filename = basename(imageResult.link);
  Response response = await Dio().get(
    imageResult.original,
    options: Options(responseType: ResponseType.bytes),
  );

  final result = await ImageGallerySaver.saveImage(
    Uint8List.fromList(response.data),
    name: filename,
  );
  // TODO: Add notification that image was saved
  print(result);
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
