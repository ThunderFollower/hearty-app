import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

const _defaultDecoration = BoxDecoration(shape: BoxShape.circle);
final _defaultButtonStyle = ElevatedButton.styleFrom(
  alignment: Alignment.center,
  shape: const CircleBorder(),
  padding: EdgeInsets.zero,
  elevation: 0.0,
);

/// Encapsulate a view model describing a customized appearance of circle
/// button.
class CircleButtonThemeData {
  /// Create a new instance of [CircleButtonThemeData].
  factory CircleButtonThemeData({
    BoxDecoration? backgroundDecoration,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    ButtonStyle? style,
  }) {
    final newBackgroundDecoration =
        _defaultDecoration.merge(backgroundDecoration);
    final newDecoration = _defaultDecoration.merge(decoration);
    // The [ButtonStyle.merge] method only updates null fields in
    // Flutter v2.10.4
    // We merge the default into the custom style because the custom style has
    // a higher priority.
    final newStyle = style?.merge(_defaultButtonStyle) ?? _defaultButtonStyle;

    return CircleButtonThemeData._(
      backgroundDecoration: newBackgroundDecoration,
      decoration: newDecoration,
      padding: padding,
      style: newStyle,
    );
  }

  /// Create a [CircleButtonThemeData] with the given [radius].
  factory CircleButtonThemeData.fromRadius(
    double radius, {
    BoxDecoration? backgroundDecoration,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
  }) {
    final style = ElevatedButton.styleFrom(fixedSize: Size.fromRadius(radius));

    return CircleButtonThemeData(
      backgroundDecoration: backgroundDecoration,
      decoration: decoration,
      padding: padding,
      style: style,
    );
  }

  const CircleButtonThemeData._({
    this.backgroundDecoration,
    this.decoration,
    this.padding,
    this.style,
  });

  /// A decoration of the background of the button.
  final BoxDecoration? backgroundDecoration;

  /// A decoration of the button foreground content.
  final BoxDecoration? decoration;

  /// A padding of the button content (foreground).
  final EdgeInsetsGeometry? padding;

  /// A customized appearance of a circle button.
  ///
  /// If non-null, overrides the default [ElevatedButtonThemeData.style].
  ///
  /// Null by default.
  final ButtonStyle? style;

  /// Returns a copy of this [CircleButtonThemeData] with the given fields
  /// replaced with the new values.
  CircleButtonThemeData copyWith({
    BoxDecoration? backgroundDecoration,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    ButtonStyle? style,
  }) =>
      CircleButtonThemeData(
        backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
        decoration: decoration ?? this.decoration,
        padding: padding ?? this.padding,
        style: style ?? this.style,
      );

  /// Returns a copy of this [CircleButtonThemeData] where the non-null fields
  /// in [data] have replaced the corresponding null fields in this
  /// [CircleButtonThemeData].
  CircleButtonThemeData merge(CircleButtonThemeData? data) {
    if (data == null) return this;
    return copyWith(
      backgroundDecoration: data.backgroundDecoration ?? backgroundDecoration,
      decoration: data.decoration ?? decoration,
      padding: data.padding ?? padding,
      style: data.style ?? style,
    );
  }

  @override
  int get hashCode => Object.hash(
        backgroundDecoration,
        decoration,
        padding,
        style,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is CircleButtonThemeData &&
        other.backgroundDecoration == backgroundDecoration &&
        other.decoration == decoration &&
        other.padding == padding &&
        other.style == style;
  }
}
