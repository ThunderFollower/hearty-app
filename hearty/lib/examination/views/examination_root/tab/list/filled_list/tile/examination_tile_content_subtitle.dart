part of 'examination_tile.dart';

class _ContentSubtitle extends StatelessWidget {
  final String examinationId;
  final bool? received;

  const _ContentSubtitle(
    this.examinationId, {
    this.received,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: halfOfLowestIndent),
          __Timestamp(examinationId: examinationId),
        ],
      );
}

class __Timestamp extends ConsumerWidget {
  final String examinationId;

  const __Timestamp({required this.examinationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = examinationTileStateProvider(examinationId);
    final date = ref.watch(provider.select((value) => value.modificationDate));
    return __Label(date, placeholder: const __TextSkeleton());
  }
}

class __Findings extends ConsumerWidget {
  static const _padding = EdgeInsets.only(top: halfOfLowestIndent);

  final String examinationId;

  const __Findings({required this.examinationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = examinationTileStateProvider(examinationId);
    final data = ref.watch(provider.select((value) => value.priorFinding));
    return _wrapLabel(__Label(data));
  }

  Widget _wrapLabel(Widget label) => Padding(padding: _padding, child: label);
}

class __ReceivedFrom extends ConsumerWidget {
  final String examinationId;
  const __ReceivedFrom({required this.examinationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = examinationTileStateProvider(examinationId);
    final email = ref.watch(provider.select((value) => value.from));
    return _buildLabel(email);
  }

  Widget _buildLabel(String? email) => __Label(
        _format(email),
        placeholder: const __TextSkeleton(),
      );

  String? _format(String? email) {
    if (email == null) return null;
    return LocaleKeys.ExaminationTile_from.tr(args: [email]);
  }
}

class __Label extends StatelessWidget {
  final String? data;
  final Widget? placeholder;

  const __Label(this.data, {this.placeholder});

  @override
  Widget build(BuildContext context) {
    final text = data;
    if (text == null) return const __TextSkeleton();

    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onPrimaryContainer;
    final textStyle = theme.textTheme.bodySmall?.copyWith(color: textColor);

    return text.isNotEmpty
        ? Text(text, style: textStyle, overflow: TextOverflow.ellipsis)
        : _buildPlaceholder();
  }

  Widget _buildPlaceholder() => placeholder ?? const SizedBox.shrink();
}

class __TextSkeleton extends StatelessWidget {
  const __TextSkeleton();

  static const style = SkeletonLineStyle(
    height: 16,
    alignment: Alignment.centerLeft,
  );

  @override
  Widget build(BuildContext context) => const SkeletonLine(style: style);
}
