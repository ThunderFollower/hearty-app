part of 'pdf_viewer_sheet.dart';

class _Layout extends StatelessWidget {
  final Widget child;

  static const _margin = EdgeInsets.only(
    left: lowIndent,
    right: lowIndent,
    bottom: lowIndent,
    top: statusBarIndent,
  );
  static final _borderRadius = BorderRadius.circular(highIndent);

  const _Layout({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.topCenter,
      margin: _margin,
      decoration: buildDecoration(theme),
      clipBehavior: Clip.antiAlias,
      child: buildTheme(theme),
    );
  }

  Widget buildTheme(ThemeData theme) {
    final appBarTheme = theme.appBarTheme.copyWith(
      color: theme.colorScheme.primaryContainer,
    );

    return Theme(
      data: theme.copyWith(appBarTheme: appBarTheme),
      child: child,
    );
  }

  BoxDecoration buildDecoration(ThemeData theme) => BoxDecoration(
        borderRadius: _borderRadius,
        color: theme.colorScheme.primaryContainer,
      );
}
