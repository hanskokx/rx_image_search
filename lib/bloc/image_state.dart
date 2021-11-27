part of 'image_bloc.dart';

class HasImages extends ImageState {
  // final Stream<Map<String, String>> data;
  final List<ImageResult?> data;
  final String query;
  HasImages({
    required this.data,
    required this.query,
  });
}

class ImageInitial extends ImageState {}

@immutable
abstract class ImageState {}

class Searching extends ImageState {
  final String query;
  Searching({
    required this.query,
  });
}
