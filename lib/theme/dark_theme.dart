import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'SFProText',
  primaryColor: const Color.fromARGB(255, 160, 3, 32),
  primaryColorDark: const Color.fromARGB(255, 160, 3, 32),
  disabledColor: const Color(0xFFBABFC4),
  scaffoldBackgroundColor: const Color(0xFF1C1F1F),
  brightness: Brightness.dark,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.black26,
  textTheme:  const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Color(0xffd5e1e0)),
  ),
  colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 160, 3, 32),
      error: Color.fromARGB(255, 191, 39, 42),
      background: Color(0xFFF3F3F3),
      secondary: Color.fromARGB(255, 160, 3, 32),
      tertiary: Color.fromARGB(255, 220, 166, 111),
      tertiaryContainer: Color(0xFFC98B3E),
      secondaryContainer: Color.fromARGB(255, 190, 53, 53),
      onTertiary: Color(0xFFD9D9D9),
      onSecondary: Color.fromARGB(255, 254, 135, 0),
      onSecondaryContainer: Color(0xFFA8C5C1),
      onTertiaryContainer: Color(0xFF425956),
      outline: Color.fromARGB(255, 255, 201, 140),
      onPrimaryContainer: Color(0xFFDEFFFB),
      primaryContainer: Color(0xFFFFA800),
      onSurface: Color(0xFFFFE6AD),
      onPrimary: Color.fromARGB(255, 160, 3, 32),


  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color.fromARGB(255, 160, 3, 32),)),
);
