part of '../record_report.dart';

class _InsufficientQualityPattern extends StatelessWidget {
  const _InsufficientQualityPattern({
    required this.height,
    required this.segmentWidth,
  });

  final double height;
  final double segmentWidth;

  @override
  Widget build(BuildContext context) {
    final imageNumber =
        (segmentWidth / _insufficientQualityPatternWidth).ceil();
    return SizedBox(
      height: height,
      width: segmentWidth,
      child: UnconstrainedBox(
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: List.generate(
            imageNumber,
            (_) => const LocalImage(
              assetPath: _insufficientQualityBackgroundPath,
            ),
          ),
        ),
      ),
    );
  }
}
