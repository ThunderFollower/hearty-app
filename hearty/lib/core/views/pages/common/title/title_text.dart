import 'package:flutter/material.dart';

/// This widget is designed to display a single line of text.
/// If the text overflows its parent constrictions it will be scaled down
/// to fit. It also provides a custom semantics label for accessibility
/// purposes.
class TitleText extends StatelessWidget {
  /// Creates a [TitleText] widget.
  ///
  /// The [data] parameter must not be null and is the text to be displayed.
  const TitleText(this.data);

  /// The text data to be displayed by the widget.
  final String data;

  @override
  Widget build(BuildContext context) => FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          data,
          semanticsLabel: semanticsLabel,
        ),
      );

  @visibleForTesting
  @protected
  String? get semanticsLabel =>
      '${data.toLowerCase().replaceAll(' ', '_')}_page';
}
