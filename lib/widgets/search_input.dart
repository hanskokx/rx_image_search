import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rx_image_search/bloc/image_bloc.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchInput = TextEditingController();
  bool _showClearIcon = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _searchInput,
        style: Theme.of(context).textTheme.headline6,
        onSubmitted: (value) => {
          BlocProvider.of<ImageBloc>(context).add(SearchForImages(query: value))
        },
        onChanged: (String value) {
          if (value.isNotEmpty) {
            setState(() {
              _showClearIcon = true;
            });
          }
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search for an image...',
          suffixIcon: Visibility(
            visible: _showClearIcon,
            child: GestureDetector(
              onTap: () {
                _searchInput.clear();
                setState(() {
                  _showClearIcon = false;
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.clear),
              ),
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 8,
            minHeight: 8,
          ),
        ),
      ),
    );
  }
}
