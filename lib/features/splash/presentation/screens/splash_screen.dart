import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check the current theme's brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Select the appropriate logo based on the theme
    final logoAsset = isDark
        ? 'assets/images/logo/logo_caption_dark.png'
        : 'assets/images/logo/logo_caption_light.png';

    return Scaffold(
      body: Center(
        child: Image.asset(
          logoAsset,
          fit: BoxFit.cover,
          width: 512,
        ),
      ),
    );
  }
}
