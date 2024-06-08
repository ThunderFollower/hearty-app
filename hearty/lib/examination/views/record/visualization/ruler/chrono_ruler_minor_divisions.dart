part of 'chrono_ruler.dart';

class _MinorDivisions extends StatelessWidget {
  const _MinorDivisions({
    required this.unitWidth,
    required this.units,
  });

  final double unitWidth;
  final int units;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 4,
        child: buildListView(),
      );

  Widget buildListView() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: buildItem,
        itemCount: units,
      );

  Widget buildItem(BuildContext context, int index) => SizedBox(
        width: unitWidth,
        child: buildRow(),
      );

  Widget buildRow() => const Row(
        children: [
          _Graduation(),
          Spacer(),
        ],
      );
}
