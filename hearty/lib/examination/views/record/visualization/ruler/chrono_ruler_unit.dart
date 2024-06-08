part of 'chrono_ruler.dart';

class _Unit extends StatelessWidget {
  const _Unit({
    required this.width,
    required this.value,
  });

  final double width;
  final double value;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        child: Row(
          children: [
            const _Graduation(),
            const SizedBox(width: 4),
            Expanded(child: _UnitText(value: value)),
          ],
        ),
      );
}
