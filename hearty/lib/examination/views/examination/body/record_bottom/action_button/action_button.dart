import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Widget icon;
  final bool showBadge;

  const ActionButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.showBadge,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 40),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                icon,
                if (showBadge) _badge(),
              ],
            ),
            const SizedBox(width: 4),
            Text(title),
          ],
        ),
      ),
    );
  }

  static const double _badgeSize = 8;
  static const double _badgeLeft = -5;
  static const double _badgeTop = -2;

  Widget _badge() => _Badge(
        top: _badgeTop,
        left: _badgeLeft,
        size: _badgeSize,
        color: Colors.pink.shade500,
      );
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.top,
    required this.left,
    required this.size,
    this.color,
  });

  final double top;
  final double left;
  final double size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(shape: BoxShape.circle, color: color);
    final container = Container(decoration: decoration);
    return Positioned(
      left: left,
      top: top,
      width: size,
      height: size,
      child: container,
    );
  }
}
