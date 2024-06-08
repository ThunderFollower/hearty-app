import 'package:flutter/widgets.dart';
import 'measure_size_render_object.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSize extends SingleChildRenderObjectWidget {
  const MeasureSize({
    super.key,
    required this.onChange,
    required Widget super.child,
  });

  final OnWidgetSizeChange onChange;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      MeasureSizeRenderObject(onChange);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant MeasureSizeRenderObject renderObject,
  ) {
    renderObject.onChange = onChange;
  }
}
