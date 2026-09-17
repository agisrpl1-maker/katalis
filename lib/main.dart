import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const CatalystApp());
}

class CatalystApp extends StatefulWidget {
  const CatalystApp({super.key});

  @override
  State<CatalystApp> createState() => _CatalystAppState();
}

class _CatalystAppState extends State<CatalystApp> {
  bool darkMode = false;

  void toggleTheme() {
    setState(() {
      darkMode = !darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Buku Kas Katalis",

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,

          brightness: Brightness.dark,
        ),
      ),

      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,

      home: SplashScreen(darkMode: darkMode, onThemeChanged: toggleTheme),
    );
  }
}
