import 'package:flutter/material.dart';

class StrokeButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool enabled;
  final double width;
  final double height;
  final double fontSize;

  const StrokeButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.enabled = true,
    this.width = double.maxFinite,
    this.height = 56,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mainColor = theme.colorScheme.onSurface;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: mainColor.withOpacity(enabled ? 1 : 0.4),
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (enabled) onPressed?.call();
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            key: _openEmailAppButtonKey,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              color: mainColor.withOpacity(enabled ? 1 : 0.4),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

const _openEmailAppButtonKey = Key('open_email_app_button_key');
