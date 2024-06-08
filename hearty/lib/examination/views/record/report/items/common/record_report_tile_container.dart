part of '../record_report.dart';

class _TileContainer extends StatelessWidget {
  const _TileContainer({
    required this.child,
    this.padding,
    this.backgroundColor,
    this.hasBorder = true,
  });

  final Widget child;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    final border = Border.all(
      color: Theme.of(context).colorScheme.background,
      width: 2,
    );
    final decoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(lowIndent)),
      border: hasBorder ? border : null,
    );
    return Container(
      padding: padding,
      width: double.infinity,
      decoration: decoration,
      child: child,
    );
  }
}
