import 'package:flutter/material.dart';

class BuildBottomSheet extends StatelessWidget {
  const BuildBottomSheet({required this.nextPage,required this.skip,super.key});

  final void Function() nextPage;
  final void Function() skip;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        ElevatedButton(
          onPressed: skip,
          child: const Text('Skip'),
        ),
        ElevatedButton(
          onPressed: nextPage,
          child: const Text('Next'),
        ),
      ]),
    );
  }
}
