import 'package:flutter/material.dart';
import 'package:happy_app/core/features/moments/pages/main_page.dart';
import 'package:happy_app/core/features/navigation/pages/custom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomNavigationBar(),
    );
  }
}
