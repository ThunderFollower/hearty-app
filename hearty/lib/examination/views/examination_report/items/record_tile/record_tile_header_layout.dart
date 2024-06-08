part of 'record_tile.dart';

class _HeaderLayout extends StatelessWidget {
  final Widget spot;
  final Widget timestamp;
  final Widget heartRate;

  const _HeaderLayout({
    required this.spot,
    required this.timestamp,
    required this.heartRate,
  });

  @override
  Widget build(BuildContext context) {
    final leftSide = Row(
      children: [
        spot,
        const SizedBox(width: belowLowIndent),
        timestamp,
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: leftSide),
        heartRate,
      ],
    );
  }
}
