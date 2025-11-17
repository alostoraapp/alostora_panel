import 'package:flutter/material.dart';

/// This widget is not meant to be used visually.
/// It's a workaround to prevent the Flutter web build's tree-shaking
/// from removing icons that are used dynamically in the app.
/// By referencing them here, we ensure they are included in the font subset.
class IconTreeShakingWorkaround extends StatelessWidget {
  const IconTreeShakingWorkaround({super.key});

  @override
  Widget build(BuildContext context) {
    // This widget should never be built. The if(false) block ensures that,
    // but the static analysis of the build tool will still see the icons.
    if (false) {
      return const Column(
        children: [
          Icon(Icons.light_mode),
          Icon(Icons.dark_mode),
          Icon(Icons.language),
          Icon(Icons.visibility),
          Icon(Icons.visibility_off),
          Icon(Icons.logout),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
