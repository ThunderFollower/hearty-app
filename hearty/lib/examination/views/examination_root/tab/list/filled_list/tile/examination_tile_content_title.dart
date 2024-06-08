part of 'examination_tile.dart';

class _ContentTitle extends ConsumerWidget {
  final String examinationId;

  const _ContentTitle(this.examinationId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = examinationTileStateProvider(examinationId);
    final data = ref.watch(provider.select((value) => value.title));

    return data == null ? const __TitleSkeleton() : _wrapText(_buildText(data));
  }

  Widget _buildText(String data) => Text(data, overflow: TextOverflow.ellipsis);

  Widget _wrapText(Widget text) => Expanded(child: text);
}

class __TitleSkeleton extends StatelessWidget {
  const __TitleSkeleton();

  static const width = 154.0;
  static const height = 20.0;
  static const maxScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final ratio = MediaQuery.sizeOf(context).width / standardUiSize.width;
    final scale = min(ratio, maxScale);

    final style = SkeletonLineStyle(
      width: width * scale,
      height: height,
      alignment: Alignment.centerLeft,
    );

    return SkeletonLine(style: style);
  }
}
