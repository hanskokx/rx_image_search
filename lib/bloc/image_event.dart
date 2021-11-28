part of 'image_bloc.dart';

class GetNextPage extends ImageEvent {}

@immutable
abstract class ImageEvent {}

class SearchForImages extends ImageEvent {
  final String query;
  final int? page;
  SearchForImages({
    required this.query,
    this.page = 0,
  });
}
