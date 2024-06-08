part of 'record_header.dart';

class _Timestamp extends StatelessWidget {
  final DateTime? createdAt;

  const _Timestamp({required this.createdAt});

  @override
  Widget build(BuildContext context) =>
      createdAt == null ? _buildSkeleton() : _buildText(context, createdAt!);

  Widget _buildSkeleton() => const SkeletonLine(
        style: SkeletonLineStyle(
          height: 20,
          alignment: Alignment.center,
          maxLength: 180.0,
          minLength: 130.0,
        ),
      );

  Widget _buildText(BuildContext context, DateTime timestamp) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onTertiaryContainer;
    final textStyle = theme.textTheme.titleMedium?.copyWith(color: textColor);

    final localTimestamp = timestamp.toLocal();
    final data = DateFormat.yMMMd().add_jm().format(localTimestamp);
    return Text(key: _timeStampKey, data, style: textStyle);
  }
}

// Keys
const _timeStampKey = Key('time_stamp_key');
