part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class SearchForImages extends ImageEvent {
  final String query;
  SearchForImages({
    required this.query,
  });
}
