import 'package:flutter/material.dart';
import 'screens/mainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          // white background
          backgroundColor: Colors.white
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            // dark blue text
            color: Colors.black,
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: MainPage(),
    );
  }
}


