part of '../record_report.dart';

class _Findings extends StatelessWidget {
  const _Findings({
    required this.hasMurmur,
    required this.onTap,
  });

  final bool hasMurmur;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final assetPath =
        hasMurmur ? _redAttentionIconPath : _neutralAttentionIconPath;
    final findingText = hasMurmur
        ? LocaleKeys.Murmur_detected.tr()
        : LocaleKeys.Murmur_not_detected.tr();
    final image = Transform.scale(
      scale: 1.5,
      child: LocalImage(assetPath: assetPath),
    );

    return GestureDetector(
      onTap: onTap,
      child: _TileContainer(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        backgroundColor: Theme.of(context).colorScheme.background,
        hasBorder: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            const SizedBox(height: lowestIndent),
            Text(findingText),
          ],
        ),
      ),
    );
  }
}
