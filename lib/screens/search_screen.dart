import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        body: (dotenv.maybeGet('SERPAPI_API_KEY') == null)
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                      'Please ensure SERPAPI_API_KEY is set in your environment.'),
                ),
              )
            : InkWell(
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
