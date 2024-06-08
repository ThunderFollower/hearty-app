part of 'record_tile.dart';

class _SpotMark extends StatelessWidget {
  final String? name;
  final int? number;

  const _SpotMark({required this.name, required this.number});

  @override
  Widget build(BuildContext context) {
    if (name == null || number == null) return const SizedBox.shrink();
    return Flexible(child: Text('$number. $name'));
  }
}
