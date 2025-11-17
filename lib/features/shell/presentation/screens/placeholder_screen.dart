import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'You are on the $title page.',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
