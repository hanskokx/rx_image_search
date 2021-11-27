import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

// Stream<Map<String, String>> _searchForImages() async* {
//   for (int i = 0; i <= 10; i++) {
//     yield {"Image$i": "URL://$i"};
//     await Future.delayed(const Duration(seconds: 1));
//   }
// }

Map<String, String> _searchForImages() {
  return {"Image": "URL://"};
}

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ImageEvent>((event, emit) {
      if (event is SearchForImages) {
        emit(Searching(query: event.query));
        // Stream<Map<String, String>> images = _searchForImages();
        Map<String, String> images = _searchForImages();
        emit(HasImages(query: event.query, data: images));
      }
    });
  }
}
