import 'package:flutter/material.dart';

class RoundFilledButton extends StatelessWidget {
  const RoundFilledButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.size = 56,
    this.color = Colors.pink,
    this.id = 'default_id',
    this.disabledBackgroundColor = Colors.transparent,
  });

  final String id;
  final VoidCallback? onPressed;
  final Widget child;
  final double size;
  final Color? color;
  final Color disabledBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: const CircleBorder(),
        backgroundColor: color,
        disabledBackgroundColor: disabledBackgroundColor,
      ),
      onPressed: onPressed,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        child: Stack(
          children: [
            child,
            Text(
              id,
              style: const TextStyle(fontSize: 0),
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
    );
  }
}
