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
              Text(state.query),
              StaggeredGridView.countBuilder(
                shrinkWrap: true,
                crossAxisCount: 3,
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) => Container(
                    color: Colors.green,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(state.data.toString()),
                      ),
                    )),
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.extent(1, index.isEven ? 200 : 100),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
            ],
          );
        }

        return const Text('Search for something, will ya?');
      },
    );
  }
}
