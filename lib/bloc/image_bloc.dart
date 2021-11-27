import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:rx_image_search/classes/image_result.dart';

part 'image_event.dart';
part 'image_state.dart';

// Dio dio = Dio(options);

// BaseOptions options = BaseOptions(
//   baseUrl: 'https://serpapi.com/',
// );

Future<List<ImageResult?>> _searchForImages(String query) async {
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

  List<Map<String, dynamic>> res = [];
  response.data.forEach((String key, dynamic values) {
    if (key == "images_results") {
      for (Map<String, dynamic> imageResult in values) {
        res.add(jsonDecode(jsonEncode(imageResult)));
      }
    }
  });

  List<ImageResult?> results =
      res.isNotEmpty ? res.map((c) => ImageResult.fromMap(c)).toList() : [];

  return results;
}

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ImageEvent>((event, emit) async {
      if (event is SearchForImages) {
        emit(Searching(query: event.query));
        // Stream<Map<String, String>> images = _searchForImages();
        List<ImageResult?> images = await _searchForImages(event.query);
        emit(HasImages(query: event.query, data: images));
      }
    });
  }
}
