import 'package:flutter/material.dart';

/// Define a [BoxDecoration] extension to support merging with another
/// [BoxDecoration] object.
extension MergeBoxDecoration on BoxDecoration {
  /// Return a copy of this [BoxDecoration] where the non-null fields in
  /// [other] have replaced the corresponding null fields in this
  /// [BoxDecoration].
  BoxDecoration merge(BoxDecoration? other) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      image: other.image,
      border: other.border,
      borderRadius: other.borderRadius,
      boxShadow: other.boxShadow,
      gradient: other.gradient,
      backgroundBlendMode: other.backgroundBlendMode,
      shape: other.shape,
    );
  }
}
