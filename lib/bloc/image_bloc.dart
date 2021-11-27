import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

// Stream<Map<String, String>> _searchForImages() async* {
//   for (int i = 0; i <= 10; i++) {
//     yield {"Image$i": "URL://$i"};
//     await Future.delayed(const Duration(seconds: 1));
//   }
// }

Future<Response> _searchForImages(String query) async {
  // Map<String, dynamic> data = {
  //   "q": query,
  //   "tbm": "isch",
  //   "ijn": 0,
  //   "api_key": SystemConfig.getOrNull("SERPAPI_API_KEY")
  // };

  // Response response = await dio.request(
  //   '/search',
  //   queryParameters: data,
  //   options: Options(method: 'GET'),
  // );

  BaseOptions options = BaseOptions(
    baseUrl: 'https://tempapi.proj.me/api',
  );
  Dio client = Dio(options);

  Response response = await client.request(
    "/Z8oF121Jb",
  );

  return response;
}

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ImageEvent>((event, emit) async {
      if (event is SearchForImages) {
        emit(Searching(query: event.query));
        // Stream<Map<String, String>> images = _searchForImages();
        Response images = await _searchForImages(event.query);
        emit(HasImages(query: event.query, data: images));
      }
    });
  }
}
