import 'package:flutter/material.dart';

MaterialColor swatch = createMaterialColor('#3c4255');

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: swatch,
  ),
  canvasColor: swatch[50],
);

MaterialColor createMaterialColor(String hex) {
  int hexColor = int.parse(hex.replaceFirst(RegExp(r'#'), '00'), radix: 16);

  Color color = Color(hexColor);
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(swatch[100]!.value, swatch);
}
