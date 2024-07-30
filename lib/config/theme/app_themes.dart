import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xfff6f8fb),
    fontFamily: 'Mulish',
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      color: Color(0xfff6f8fb),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0XFF8b8b8b)),
      titleTextStyle: TextStyle(
        color: Color(0xff8b8b8b),
        fontSize: 18,
      ));
}
