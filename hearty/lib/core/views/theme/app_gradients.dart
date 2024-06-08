import 'dart:math';

import 'package:flutter/material.dart';

import 'app_colors.dart';

/// This class defines the application color gradients accordingly to the
/// Application Style Guide. See the Application
/// [Style Guide](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=2949%3A18914).
///
/// Use https://www.color-blindness.com/color-name-hue/ to find the name of the
/// color.
class AppGradients {
  AppGradients._();

  /// Defines the primary — the Brand — gradient of the application.
  static final blue1 = LinearGradient(
    begin: Alignment.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      Colors.pink,
      // Deep Sky Blue
      Colors.pink.shade800,
    ],
  );

  /// Defines the secondary gradients of the application.
  static const blue2 = LinearGradient(
    begin: Alignment.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      // Alice Blue
      Color(0xFFE9F3FB),
      // Alice Blue
      Color(0xFFDBE9F4),
    ],
  );

  /// Defines the third gradients of the application.
  static final blue3 = LinearGradient(
    begin: Alignment.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      Colors.pink.shade100,
      Colors.white,
    ],
  );

  /// Defines the red gradients of the application.
  static const red = LinearGradient(
    begin: Alignment.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      Color(0xFFF3436D),
      Color(0xFFD42A49),
    ],
  );

  static final disabledButton = LinearGradient(
    begin: Alignment.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      Colors.pink.withOpacity(0.4),
      Colors.pink.withOpacity(0.8),
    ],
  );

  static const orange = LinearGradient(
    colors: [
      Color.fromRGBO(250, 195, 105, 0.05),
      Color.fromRGBO(250, 195, 105, 0.5),
      Color.fromRGBO(250, 195, 105, 0.5),
      Color.fromRGBO(250, 195, 105, 0.05),
    ],
    stops: [0, 0.2, 0.8, 1],
  );

  static const orange2 = LinearGradient(
    colors: [
      Color.fromRGBO(250, 195, 105, 0.2),
      Color.fromRGBO(250, 195, 105, 1.0),
      Color.fromRGBO(250, 195, 105, 0.2),
    ],
    stops: [0, 0.56, 1],
  );

  static const cyan2 = LinearGradient(
    colors: [
      Color.fromRGBO(71, 193, 187, 0.05),
      Color.fromRGBO(71, 193, 187, 0.5),
      Color.fromRGBO(71, 193, 187, 0.5),
      Color.fromRGBO(71, 193, 187, 0.05),
    ],
    stops: [0, 0.2, 0.8, 1],
  );

  static final whiteStriped = LinearGradient(
    begin: Alignment.topLeft,
    end: const Alignment(-0.97, -0.97),
    stops: const [0.0, 0.05, 0.05, 1],
    colors: [
      AppColors.grey[150]!,
      AppColors.grey[150]!,
      Colors.white,
      Colors.white,
    ],
    tileMode: TileMode.repeated,
    transform: const GradientRotation(pi / 4),
  );

  static const transparent = LinearGradient(
    colors: [
      Colors.transparent,
      Colors.transparent,
    ],
  );

  static const whiteTransparent = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 0.0),
      Colors.white70,
      Colors.white70,
      Color.fromRGBO(255, 255, 255, 0.0),
    ],
    stops: [0.0, 0.1, 0.9, 1.0],
  );

  static const blueTransparent = LinearGradient(
    colors: [
      Color.fromRGBO(236, 244, 252, 0.0),
      Color.fromRGBO(236, 244, 252, 0.7),
      Color.fromRGBO(236, 244, 252, 0.7),
      Color.fromRGBO(236, 244, 252, 0.0),
    ],
    stops: [0.0, 0.1, 0.9, 1.0],
  );
}
