import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'SFProText',
 primaryColor: const Color.fromARGB(255, 160, 3, 32),
  primaryColorDark: const Color.fromARGB(255, 160, 3, 32),
  disabledColor: const Color(0xFFBABFC4),
  scaffoldBackgroundColor:const Color.fromARGB(255, 160, 3, 32),
  textTheme:  const TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Color(0xff6B7675)),

  ),

  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  colorScheme: const ColorScheme.light(
      primary: const Color.fromARGB(255, 160, 3, 32),
      //  secondary: Color(0xFF008C7B),
      error: Color.fromARGB(255, 191, 39, 42),
      background: Color(0xFFF3F3F3),
      tertiary: Color.fromARGB(255, 210, 136, 101),
      tertiaryContainer: Color(0xFFC98B3E),
      secondaryContainer: Color.fromARGB(255, 190, 53, 53),
      onTertiary: Color(0xFFD9D9D9),
      onSecondary: Color.fromARGB(255, 233, 45, 20),
      onSecondaryContainer: Color(0xFFA8C5C1),
      onTertiaryContainer: Color(0xFF425956),
      outline: Color.fromARGB(255, 245, 162, 114),
      onPrimaryContainer: Color(0xFFDEFFFB),
      primaryContainer: Color(0xFFFFA800),
      onErrorContainer: Color(0xFFFFE6AD),
      onPrimary: Color.fromARGB(255, 198, 4, 4),
      surfaceTint: const Color.fromARGB(255, 160, 3, 32),
      errorContainer: Color(0xFFF6F6F6)
  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color.fromARGB(255, 160, 3, 32),)),
);
