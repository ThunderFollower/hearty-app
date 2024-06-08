part of 'record_page.dart';

const _layoutBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(middleIndent),
  topRight: Radius.circular(middleIndent),
);

class _Layout extends StatelessWidget {
  const _Layout({
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final bottomPadding = mediaQueryData.padding.bottom == 0
        ? 10.0
        : mediaQueryData.padding.bottom;

    final theme = Theme.of(context);
    final statusBarColor = theme.colorScheme.primary;
    final contentColor = theme.colorScheme.primaryContainer;

    final boxDecoration = BoxDecoration(
      borderRadius: _layoutBorderRadius,
      color: contentColor,
    );
    final column = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
    final container = Container(
      padding: EdgeInsets.only(bottom: bottomPadding, top: lowestIndent),
      decoration: boxDecoration,
      child: column,
    );
    return AppScaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(bottom: false, child: container),
    );
  }
}
