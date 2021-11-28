import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:rx_image_search/classes/image_result.dart';

part 'image_event.dart';
part 'image_state.dart';

Future<List<ImageResult?>> _searchForImages(String query, int page) async {
  late Response response;

  // BaseOptions options = BaseOptions(
  //   baseUrl: 'https://serpapi.com/',
  // );

  // Map<String, dynamic> data = {
  //   "q": query,
  //   "tbm": "isch", // Google Image Search API
  //   "num": 10, // The number of images to return
  //   "ijn": page, // The page number of the search results
  //   "api_key": SystemConfig.getOrNull("SERPAPI_API_KEY")
  // };

  // Dio client = Dio(options);

  // response = await client.request(
  //   '/search',
  //   queryParameters: data,
  //   options: Options(method: 'GET'),
  // );

  // ! For testing; so I don't exhaust my limited API calls
  BaseOptions options = BaseOptions(
    baseUrl: 'https://tempapi.proj.me/api',
  );
  Dio client = Dio(options);

  response = await client.request(
    "/ntUSavnRD",
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
