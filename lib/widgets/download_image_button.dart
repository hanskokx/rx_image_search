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
  SMITrigger? _pressed;
  SMIBool? _hover;
  SMINumber? _loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _downloadImage(context, widget.imageResult),
      child: SizedBox(
        height: 80,
        width: 80,
        child: RiveAnimation.asset(
          'assets/animations/download_icon.riv',
          fit: BoxFit.cover,
          onInit: _onRiveInit,
          stateMachines: const ['State'],
        ),
      ),
    );
  }

  _downloadImage(BuildContext context, ImageResult imageResult) async {
    _hover?.change(true);
    PermissionStatus? permission = await _requestPermission(context);

    if (permission == PermissionStatus.granted) {
      _pressed?.fire();
      await _save(imageResult);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Permission denied'),
      ));
    }

    _hover?.change(false);
  }

  void _onRiveInit(Artboard artboard) {
    final StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State');
    artboard.addController(controller!);
    _hover = controller.findInput<bool>('Hover') as SMIBool;
    _pressed = controller.findInput<bool>('Pressed') as SMITrigger;
    _loading = controller.findInput<double>('Loading') as SMINumber;
  }

  Future<PermissionStatus?> _requestPermission(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final PermissionStatus? info = statuses[Permission.storage];
    return info;
  }

  _save(ImageResult imageResult) async {
    String filename = basename(imageResult.link);
    Response response = await Dio().get(
      imageResult.original,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: (int count, int total) {
        double percent = ((count / total) * 100);
        _loading?.change(percent);
      },
    );

    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      name: filename,
      quality: 100,
    );
    // TODO: Add some error handling
    print(result);
  }
}
