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
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      style: BorderStyle.solid,
      color: Color(0xff59befc),
    ),
  ),
  prefixStyle: TextStyle(
    color: Colors.white,
  ),
);

SnackBarThemeData snackbarTheme = const SnackBarThemeData(
  backgroundColor: Color(0xff313857),
  contentTextStyle: TextStyle(
    color: Color(0xfffffbff),
  ),
);

ThemeData theme = ThemeData(
  fontFamily: 'LexendDeca',
  inputDecorationTheme: inputDecoration,
  snackBarTheme: snackbarTheme,
  colorScheme: const ColorScheme(
    background: Color(0xff010317),
    brightness: Brightness.dark,
    error: Color(0xffe0526c),
    onBackground: Color(0xfffffbff),
    onError: Color(0xfffffbff),
    onPrimary: Color(0xfffffbff),
    onSecondary: Color(0xfffffbff),
    onSurface: Color(0x25FFFBFF),
    primary: Color(0xff59befc),
    secondary: Color(0xff59befc),
    surface: Color(0xff010317),
  ),
);
