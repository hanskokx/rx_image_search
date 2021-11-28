import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:rx_image_search/classes/image_result.dart';

part 'image_event.dart';
part 'image_state.dart';

Future<List<ImageResult?>> _searchForImages(String query, int? page) async {
  late Response response;
  // * Production code
  // String apiKey =
  //     '1c4cb5c1db9de325de122d59121b2e304d6794a81ff1682578bc29a63f1c5d54';

  // BaseOptions options = BaseOptions(
  //   baseUrl: 'https://serpapi.com/',
  // );

  // Map<String, dynamic> data = {
  //   "q": query,
  //   "tbm": "isch", // Google Image Search API
  //   "num": 15, // The number of images to return
  //   "ijn": page ?? 0, // The page number of the search results
  //   "api_key": apiKey,
  // };

  // Dio client = Dio(options);

  // try {
  //   response = await client.request(
  //     '/search',
  //     queryParameters: data,
  //     options: Options(method: 'GET'),
  //   );
  // } catch (error) {
  //   debugPrint(error.toString());
  //   rethrow;
  // }
  // * End production code

  // ! For testing; so I don't exhaust my limited API calls
  BaseOptions options = BaseOptions(
    baseUrl: 'https://tempapi.proj.me/api',
  );
  Dio client = Dio(options);

  response = await client.request(
    "/ntUSavnRD",
  );
  // ! End testing code

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
    int page = 0;
    String query = '';
    List<ImageResult?> allImages = [];
    on<ImageEvent>((event, emit) async {
      if (event is SearchForImages) {
        emit(Searching(query: event.query));
        if (event.query != query) {
          page = 0;
          allImages.clear();
        }

        page = event.page!;
        query = event.query;
        await Future.delayed(const Duration(seconds: 3));
        List<ImageResult?> images = await _searchForImages(query, page);
        allImages.addAll(images);
        emit(HasImages(query: query, data: allImages));
      }

      if (event is GetNextPage) {
        page++;
        List<ImageResult?> images = await _searchForImages(query, page);
        allImages.addAll(images);
        emit(HasImages(query: query, data: allImages));
      }
    });
  }
}
