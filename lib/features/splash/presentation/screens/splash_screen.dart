import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo/logo_caption_light.png'),
          fit: BoxFit.cover,
          width: 512,
        ),
      ),
    );
  }
}