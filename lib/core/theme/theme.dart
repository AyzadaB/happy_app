import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeConstants{
 
  static ThemeData theme = ThemeData(
        brightness: Brightness.dark, // Караңгы теманы колдонуу
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.black, // Жалпы фон түсү
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.red[800]!),
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
      );
}