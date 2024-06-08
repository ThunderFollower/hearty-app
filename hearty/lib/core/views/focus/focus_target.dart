import 'package:flutter/material.dart';

/// Implements a widget that clears the keyboard focus from children when it
/// gets tapped.
class FocusTarget extends StatelessWidget {
  /// Clear the keyboard focus from [child] when it gets tapped.
  const FocusTarget({
    super.key,
    required this.child,
  });

  /// The widget below this widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: child,
      );
}
