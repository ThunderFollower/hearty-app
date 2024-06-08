part of 'segmented_visualization.dart';

class _Surface extends StatelessWidget {
  const _Surface({
    required this.child,
    required this.isSpectrogramMode,
    required this.onChangeMode,
    required this.onScaleStart,
    required this.onScaleUpdate,
    required this.onScaleEnd,
    required this.onHorizontalDragDown,
    required this.onHorizontalDragUpdate,
    required this.onHorizontalDragEnd,
    required this.onHorizontalDragCancel,
  });

  final Widget child;

  /// Indicates if the spectrogram mode is active.
  final bool? isSpectrogramMode;
  final VoidCallback? onChangeMode;

  final GestureScaleStartCallback? onScaleStart;
  final GestureScaleUpdateCallback? onScaleUpdate;
  final GestureScaleEndCallback? onScaleEnd;

  final GestureDragDownCallback? onHorizontalDragDown;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final GestureDragCancelCallback? onHorizontalDragCancel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onScaleStart: onScaleStart,
          onScaleUpdate: onScaleUpdate,
          onScaleEnd: onScaleEnd,
          onHorizontalDragDown: onHorizontalDragDown,
          onHorizontalDragUpdate: onHorizontalDragUpdate,
          onHorizontalDragEnd: onHorizontalDragEnd,
          onHorizontalDragCancel: onHorizontalDragCancel,
          dragStartBehavior: DragStartBehavior.down,
          child: child,
        ),
        VisualizationModeSwitcher(
          isSpectrogramMode: isSpectrogramMode,
          onTap: onChangeMode,
        ),
        const CentralMark(key: Key('Visualization_CentralMark')),
      ],
    );
  }
}
