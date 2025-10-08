import 'package:flutter/material.dart';

class DottedLineBorder extends StatelessWidget {
  const DottedLineBorder({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    int numberOfDots = (screenWidth / 4).floor();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 4.0,
        children: List.generate(numberOfDots, (index) {
          return Container(
            height: 1,
            width: 4,
            color: _theme.colorScheme.outline,
          );
        }),
      ),
    );
  }
}
