part of 'segmentation_panel.dart';

class _Background extends StatelessWidget {
  const _Background({
    required this.width,
    required this.padding,
  });

  final double width;
  final double padding;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: segmentationPanelHeight,
        margin: EdgeInsets.only(right: padding),
        color: Theme.of(context).colorScheme.primary,
      );
}
