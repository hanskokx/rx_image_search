import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rx_image_search/utils/navigator_argument_extractor.dart';
import 'package:rx_image_search/widgets/download_image_button.dart';

class ImageDetailScreen extends StatefulWidget {
  static const String id = 'image_detail_screen';
  const ImageDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ImageDetailScreenState createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  late RiveAnimationController _controller;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              args.imageResult.title,
              style: Theme.of(context).textTheme.headline6,
            ),
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
                imageUrl: args.imageResult.original,
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
                        animations: const [
                          'infinite',
                          'BackAndForth',
                          '0to100'
                        ],
                        controllers: [_controller],
                      ),
                    ),
                  );
                },
              ),
            ),
            DownloadImageButton(imageResult: args.imageResult),
          ],
        ),
      ),
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
