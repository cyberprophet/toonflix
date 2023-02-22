import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';

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
      home: const Scaffold(
        backgroundColor: Color(0xFFF4EDDB),
        body: HomeScreen(),
      ),
    );
  }

  const App({super.key});

  final bgColor = const Color(0xFFE7626C);
}
