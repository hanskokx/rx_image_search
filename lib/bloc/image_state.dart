part of 'image_bloc.dart';

class HasImages extends ImageState {
  // final Stream<Map<String, String>> data;
  final List<ImageResult?> data;
  final String query;
  final int? page;
  HasImages({
    required this.data,
    required this.query,
    this.page = 0,
  });
}

class ImageInitial extends ImageState {}

@immutable
abstract class ImageState {}

class Searching extends ImageState {
  final String query;
  final int? page;
  Searching({
    required this.query,
    this.page = 0,
  });
}
