import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rx_image_search/bloc/image_bloc.dart';
import 'package:rx_image_search/constants/theme.dart';
import 'package:rx_image_search/screens/image_detail_screen.dart';
import 'package:rx_image_search/screens/search_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BlocProvider(
      create: (context) => ImageBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: {
        '/': (context) => const SearchScreen(),
        SearchScreen.id: (context) => const SearchScreen(),
        ImageDetailScreen.id: (context) => const ImageDetailScreen(),
      },
    );
  }
}
