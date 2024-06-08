part of '../record_report.dart';

class _CycleNumber extends StatelessWidget {
  const _CycleNumber({
    required this.number,
    required this.cycleWidth,
    required this.defaultGap,
  });

  final int number;
  final double cycleWidth;
  final double defaultGap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cycleWidth + defaultGap,
      height: _cycleNumberHeight,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '${number + 1}',
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
