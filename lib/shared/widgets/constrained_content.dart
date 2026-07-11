import 'package:flutter/material.dart';

class ConstrainedContent extends StatelessWidget {
  final Widget child;

  const ConstrainedContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820),
        child: child,
      ),
    );
  }
}
