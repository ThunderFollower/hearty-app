part of 'playback_controls.dart';

class _SpeedButton extends StatelessWidget {
  const _SpeedButton({
    super.key,
    required this.speed,
    required this.onSpeedChanged,
  });

  final double? speed;
  final VoidCallback? onSpeedChanged;

  @override
  Widget build(BuildContext context) {
    final value = speed;
    if (value == null || onSpeedChanged == null) {
      return const _FilterButtonSkeleton();
    }
    final theme = Theme.of(context);
    final text = _buildSpeedText(value, theme);
    return TextButton(onPressed: onSpeedChanged, child: text);
  }

  Widget _buildSpeedText(double value, ThemeData theme) {
    final color = theme.colorScheme.secondary;
    final textStyle = theme.textTheme.titleLarge?.copyWith(color: color);
    return Text('x${_speedFormatter.format(value)}', style: textStyle);
  }
}
