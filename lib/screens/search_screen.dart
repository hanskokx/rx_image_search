import 'package:flutter/material.dart';
import 'package:rx_image_search/widgets/image_search_result_grid.dart';
import 'package:rx_image_search/widgets/search_input.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: InkWell(
          enableFeedback: false,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: [
              Column(
                children: const [
                  Search(),
                  ImageSearchResultGrid(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
