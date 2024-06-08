import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'stripe/top_stripe.dart';
import 'theme/indentation_constants.dart';

Future<T?> showModalDialog<T>({
  required BuildContext context,
  required Widget child,
}) =>
    showModalBottomSheet<T>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => _buildModalSheet(context, child),
    );

Widget _buildModalSheet(BuildContext context, Widget child) {
  final theme = Theme.of(context);

  final column = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [const TopStripe(), _buildBody(theme, child)],
  );

  final sheetGestureDetector = GestureDetector(
    // To avoid events on the sheet body
    onTap: () {},
    child: column,
  );

  final mediaQuery = MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    child: sheetGestureDetector,
  );

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => context.router.pop(),
    child: mediaQuery,
  );
}

Widget _buildBody(ThemeData theme, Widget child) {
  final color = theme.colorScheme.primaryContainer;
  final decoration = BoxDecoration(borderRadius: _borderRadius, color: color);

  return Container(
    margin: _margin,
    padding: _padding,
    decoration: decoration,
    child: child,
  );
}

const _padding = EdgeInsets.fromLTRB(
  middleIndent,
  belowMediumIndent,
  middleIndent,
  highIndent,
);
const _margin = EdgeInsets.fromLTRB(
  lowIndent,
  lowestIndent,
  lowIndent,
  veryHighIndent,
);
final _borderRadius = BorderRadius.circular(highIndent);
