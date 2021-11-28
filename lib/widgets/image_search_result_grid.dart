import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rx_image_search/bloc/image_bloc.dart';
import 'package:rx_image_search/widgets/image_search_result_thumbnail.dart';

class ImageSearchResultGrid extends StatelessWidget {
  const ImageSearchResultGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        if (state is Searching) {
          return const CircularProgressIndicator();
        }

        if (state is HasImages) {
          return Expanded(
            child: SingleChildScrollView(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                shrinkWrap: true,
                itemCount: state.data.length - 1,
                itemBuilder: (BuildContext context, int index) =>
                    ImageSearchResultThumbnail(
                  imageResult: state.data[index],
                ),
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.extent(1, index.isEven ? 200 : 100),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
              ),
            ),
          );
        }
        BlocProvider.of<ImageBloc>(context).add(SearchForImages(query: "asdf"));

        return const Center(child: Text('Search for something, will ya?'));
      },
    );
  }
}
