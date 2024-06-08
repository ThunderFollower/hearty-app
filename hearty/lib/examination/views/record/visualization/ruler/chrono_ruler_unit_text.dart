part of 'chrono_ruler.dart';

class _UnitText extends StatelessWidget {
  const _UnitText({required this.value});

  static final unitFormatter = NumberFormat('#0.0');
  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.secondary;
    final style = theme.textTheme.bodySmall?.copyWith(color: color);
    return Text(unitFormatter.format(value), style: style);
  }
}
