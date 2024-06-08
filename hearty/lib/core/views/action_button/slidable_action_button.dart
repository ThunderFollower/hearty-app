import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const SlidableActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      backgroundColor: Colors.pink,
      foregroundColor: Colors.white,
      icon: icon,
      onPressed: (_) => onPressed(),
    );
  }
}
