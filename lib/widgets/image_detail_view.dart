import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rx_image_search/classes/image_result.dart';
import 'package:rx_image_search/widgets/download_image_button.dart';

class ImageDetailView extends StatefulWidget {
  final ImageResult imageResult;

  const ImageDetailView({
    Key? key,
    required this.imageResult,
  }) : super(key: key);

  @override
  State<ImageDetailView> createState() => _ImageDetailViewState();
}

class _ImageDetailViewState extends State<ImageDetailView> {
  late RiveAnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.imageResult.title),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                repeat: ImageRepeat.repeat,
                image: AssetImage('assets/images/checkerboard.png'),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.imageResult.original,
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
                return Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: RiveAnimation.asset(
                      'assets/animations/circular_progress.riv',
                      animations: const ['infinite', 'BackAndForth', '0to100'],
                      controllers: [_controller],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      actions: <Widget>[
        DownloadImageButton(imageResult: widget.imageResult),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'infinite',
    );
  }
}
