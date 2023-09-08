import 'package:flutter/material.dart';

class AppPalette {
  static const MaterialColor greenmaterial =
      MaterialColor(_greenmaterialPrimaryValue, <int, Color>{
    50: Color(0xFFEAF6E9),
    100: Color(0xFFCBE8C9),
    200: Color(0xFFA8D8A5),
    300: Color(0xFF85C880),
    400: Color(0xFF6ABD65),
    500: Color(_greenmaterialPrimaryValue),
    600: Color(0xFF49AA43),
    700: Color(0xFF40A13A),
    800: Color(0xFF379832),
    900: Color(0xFF278822),
  });
  static const int _greenmaterialPrimaryValue = 0xFF50B14A;

  static const MaterialColor greenmaterialAccent =
      MaterialColor(_greenmaterialAccentValue, <int, Color>{
    100: Color(0xFFC8FFC6),
    200: Color(_greenmaterialAccentValue),
    400: Color(0xFF66FF60),
    700: Color(0xFF4EFF47),
  });
  static const int _greenmaterialAccentValue = 0xFF97FF93;
}
