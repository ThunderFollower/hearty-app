part of 'record_error.dart';

class _Text extends StatelessWidget {
  const _Text();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.error;
    final textStyle = theme.textTheme.titleLarge?.copyWith(color: textColor);
    return Text(
      LocaleKeys.Playback_error_Please_try_again_or_rerecord.tr(),
      textAlign: TextAlign.center,
      style: textStyle,
    );
  }
}
