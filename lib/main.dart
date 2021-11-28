import 'package:configurable/dotenv_configuration_provider.dart';
import 'package:configurable/system_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rx_image_search/bloc/image_bloc.dart';
import 'package:rx_image_search/widgets/image_search_result_grid.dart';
import 'package:rx_image_search/widgets/search.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DotenvConfigurationProvider dotenvProvider = DotenvConfigurationProvider();
  SystemConfig.setProvider(dotenvProvider);

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: const [
          Search(),
          ImageSearchResultGrid(),
        ],
      ),
    );
  }
}
