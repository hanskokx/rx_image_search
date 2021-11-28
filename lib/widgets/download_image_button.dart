import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rive/rive.dart';
import 'package:rx_image_search/classes/image_result.dart';

class DownloadImageButton extends StatefulWidget {
  final ImageResult imageResult;
  const DownloadImageButton({
    Key? key,
    required this.imageResult,
  }) : super(key: key);

  @override
  State<DownloadImageButton> createState() => _DownloadImageButtonState();
}

class _DownloadImageButtonState extends State<DownloadImageButton> {
  SMITrigger? _bump;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _hitBump(context, widget.imageResult),
      child: SizedBox(
        height: 80,
        width: 80,
        child: RiveAnimation.asset(
          'assets/animations/download_icon.riv',
          fit: BoxFit.cover,
          onInit: _onRiveInit,
          stateMachines: const ['State Machine 1'],
        ),
      ),
    );
  }

  _hitBump(BuildContext context, ImageResult imageResult) async {
    await _requestPermission(context);
    _bump?.fire();
    await _save(imageResult);
  }

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _bump = controller.findInput<bool>('Pressed') as SMITrigger;
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
}
