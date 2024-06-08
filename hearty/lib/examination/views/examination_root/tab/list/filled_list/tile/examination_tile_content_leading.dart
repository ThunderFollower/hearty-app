part of 'examination_tile.dart';

class _ContentLeading extends StatelessWidget {
  final String examinationId;
  const _ContentLeading(this.examinationId);

  @override
  Widget build(BuildContext context) => const _BodyImage();
}

class _BodyImage extends StatelessWidget {
  static const _bodyAssetPath = 'assets/images/logo.png';

  const _BodyImage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primaryContainer;
    final container = Container(
      height: veryHighIndent,
      width: veryHighIndent,
      color: color,
      child: const LocalImage(assetPath: _bodyAssetPath),
    );
    return ClipOval(child: container);
  }
}
