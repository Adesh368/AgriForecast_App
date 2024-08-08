import 'package:flutter/material.dart';

class BuildPage extends StatelessWidget {
  const BuildPage({
    required this.image,
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      image,
      const SizedBox(height: 20),
      Text(title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(description, textAlign: TextAlign.center),
      ),
    ]);
  }
}
