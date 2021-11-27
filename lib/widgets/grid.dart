import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rx_image_search/bloc/image_bloc.dart';

class StaggeredImageGridView extends StatelessWidget {
  const StaggeredImageGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        if (state is Searching) {
          return const CircularProgressIndicator();
        }

        if (state is HasImages) {
          return Column(
            children: [
              StaggeredGridView.countBuilder(
                shrinkWrap: true,
                crossAxisCount: 3,
                itemCount: state.data.length,
                itemBuilder: (BuildContext context, int index) =>
                    CachedNetworkImage(
                  imageUrl: state.data[index]!.thumbnail,
                ),
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.extent(1, index.isEven ? 200 : 100),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
              ),
            ],
          );
        }
        BlocProvider.of<ImageBloc>(context).add(SearchForImages(query: "asdf"));
        return const Text('Search for something, will ya?');
      },
    );
  }
}
