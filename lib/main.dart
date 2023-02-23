import 'package:flutter/material.dart';
import 'package:toonflix/screens/toonflix_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        scaffoldBackgroundColor: bgColor,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: ToonflixScreen(),
      ),
    );
  }

  const App({super.key});

  static const Color bgColor = Colors.white;
}
