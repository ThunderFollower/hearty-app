part of '../record_report.dart';

class _SkeletonTile extends StatelessWidget {
  const _SkeletonTile({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final style = SkeletonLineStyle(
      height: height,
      alignment: Alignment.center,
      borderRadius: const BorderRadius.all(Radius.circular(lowIndent)),
    );

    return SkeletonLine(style: style);
  }
}
