import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          FaIcon(FontAwesomeIcons.sun),
          FaIcon(FontAwesomeIcons.moon),
          FaIcon(FontAwesomeIcons.language),
          FaIcon(FontAwesomeIcons.eye),
          FaIcon(FontAwesomeIcons.eyeSlash),
          FaIcon(FontAwesomeIcons.signOutAlt),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
