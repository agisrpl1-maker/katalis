import 'dart:async';

import 'package:flutter/material.dart';

import 'cashbook_home.dart';

class SplashScreen extends StatefulWidget {
  final bool darkMode;
  final VoidCallback onThemeChanged;

  const SplashScreen({
    super.key,

    required this.darkMode,

    required this.onThemeChanged,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,

      duration: const Duration(seconds: 2),
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (context) => CashBookHome(
            darkMode: widget.darkMode,

            onThemeChanged: widget.onThemeChanged,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

            colors: [Color(0xffC9B8FF), Color(0xff8B6FD8), Color(0xff6A4FB3)],
          ),
        ),

        child: Center(
          child: ScaleTransition(
            scale: animation,

            child: FadeTransition(
              opacity: animation,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(35),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,

                          blurRadius: 25,

                          offset: Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Image.asset(
                      'lib/assets/catalyst_logo.png',
                      height: 120,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Catalyst",

                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 40,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Grow your business smarter",

                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
