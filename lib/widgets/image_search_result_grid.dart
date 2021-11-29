import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rx_image_search/bloc/image_bloc.dart';
import 'package:rx_image_search/classes/image_result.dart';
import 'package:rx_image_search/widgets/image_detail_view.dart';
import 'package:rx_image_search/widgets/image_search_result_thumbnail.dart';
import 'package:rx_image_search/widgets/loading_animation.dart';

class ImageSearchResultGrid extends StatefulWidget {
  final Function(bool) onImageTap;
  const ImageSearchResultGrid({
    Key? key,
    required this.onImageTap,
  }) : super(key: key);

  @override
  State<ImageSearchResultGrid> createState() => _ImageSearchResultGridState();
}

class _ImageSearchResultGridState extends State<ImageSearchResultGrid>
    with TickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  int itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is Searching) {
            return const LoadingAnimation();
          }

          if (state is HasImages) {
            itemCount = state.data.length;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: StaggeredGridView.countBuilder(
                controller: _controller,
                crossAxisCount: 3,
                shrinkWrap: true,
                itemCount: itemCount - 1,
                itemBuilder: (BuildContext context, int index) =>
                    ImageSearchResultThumbnail(
                  imageResult: state.data[index]!,
                  onTap: _enlargeImage,
                ),
                staggeredTileBuilder: (int index) =>
                    const StaggeredTile.extent(1, 100),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.image_search_outlined,
                color: Theme.of(context).colorScheme.onSurface,
                size: 72,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  Future<void> _enlargeImage(
    BuildContext context,
    ImageResult imageResult,
  ) async {
    widget.onImageTap(true);
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ImageDetailView(imageResult: imageResult);
      },
    );
  }

  _scrollListener() {
    int scrollPosition = _controller.offset.floor();
    int height = ((itemCount * 100) / 3 - 100).floor();

    if (scrollPosition >= height - 100) {
      BlocProvider.of<ImageBloc>(context).add(GetNextPage());
    }
  }
}
