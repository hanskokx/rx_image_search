import 'package:flutter/material.dart';

InputDecorationTheme inputDecoration = const InputDecorationTheme(
  filled: true,
  fillColor: Color(0xff313857),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      width: 0,
      style: BorderStyle.none,
    ),
  ),
  prefixStyle: TextStyle(
    color: Colors.white,
  ),
);

MaterialColor swatch = createMaterialColor('#414def');

ThemeData theme = ThemeData(
  inputDecorationTheme: inputDecoration,
  colorScheme: const ColorScheme(
    background: Color(0xff010317),
    brightness: Brightness.dark,
    error: Color(0xffe0526c),
    onBackground: Color(0xfffffbff),
    onError: Color(0xfffffbff),
    onPrimary: Color(0xfffffbff),
    onSecondary: Color(0xfffffbff),
    onSurface: Color(0xfffffbff),
    primary: Color(0xff59befc),
    primaryVariant: Color(0xff6163fd),
    secondary: Color(0xff1c2031),
    secondaryVariant: Color(0xff313857),
    surface: Color(0xff010317),
  ),
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
  return MaterialColor(swatch[400]!.value, swatch);
}
