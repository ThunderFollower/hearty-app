import 'package:flutter/material.dart';

// I couldn't come up with a better name
class TopStripe extends StatelessWidget {
  const TopStripe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white38,
      ),
    );
  }
}
