import 'package:flutter/material.dart';

//lightMode

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        primary: Colors.grey.shade200,
        secondary: Colors.grey.shade400,
        background: Colors.grey.shade300,
        inversePrimary: Colors.grey.shade800));

//dark mode
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: const Color.fromARGB(255, 22, 22, 22),
        primary: const Color.fromARGB(255, 47, 47, 47),
        secondary: const Color.fromARGB(255, 73, 73, 73),
        inversePrimary: Colors.grey.shade300));
