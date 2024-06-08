part of 'chrono_ruler.dart';

class _MajorDivisions extends StatelessWidget {
  const _MajorDivisions({
    required this.units,
    required this.unitWidth,
    required this.step,
    required this.base,
  });

  final int units;
  final double unitWidth;
  final int step;
  final int base;
  static const height = 20.0;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        child: buildListView(),
      );

  Widget buildListView() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: buildItem,
        itemCount: units,
      );

  Widget buildItem(BuildContext context, int index) {
    final value = index / base * step;
    return _Unit(width: unitWidth, value: value);
  }
}
