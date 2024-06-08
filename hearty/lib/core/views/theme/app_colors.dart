import 'package:flutter/material.dart';

/// This class defines the application colors accordingly to the Application Style Guide.
/// See the Application
/// [Style Guide](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=2949%3A18914).
///
/// Use https://www.color-blindness.com/color-name-hue/ to find the name of the
/// color.
class AppColors {
  AppColors._();

  /// Defines shades of the primary blue color for the application.
  /// It is also known as the brand color.
  static const blue = MaterialColor(0xFF299EB3, <int, Color>{
    900: Color(0xFF012B4D),
    700: Color(0xFF007780),
    100: Color(0xFFE9F3FB),

    // Compatibility with the Material Design

    800: Color(0xFF007780),
    600: Color(0xFF007780),
    500: Color(0xFF299EB3),
    400: Color(0xFF299EB3),
    300: Color(0xFF299EB3),
    200: Color(0xFFE9F3FB),
    150: Color(0xFFE9F3FB),
    50: Color(0xFFE9F3FB),
  });

  /// Defines shades of the Basic (Gray) color for the application.
  static const grey = MaterialColor(0xFF1B272C, <int, Color>{
    // Black Pearl
    900: Color(0xFF1B272C),
    // Ming
    700: Color(0xFF365463),
    // Jelly Bean
    500: Color(0xFF486B84),
    300: Color(0xFF91B3CA),
    // Pattens Blue
    150: Color(0xFFC2D9E5),
    // A variant of Pattens Blue
    100: Color(0xFFDBE8F0),

    // Compatibility with the Material Design
    800: Color(0xFF1B272C),
    600: Color(0xFF365463),
    400: Color(0xFF486B84),
    200: Color(0xFFDBE8F0),
    50: Color(0xFFEEF4F6),
  });

  /// Defines the overlay color that is the Black Pearl with 60% opacity.
  static const overlay = Color(0x99002332);

  /// Defines shades of the green color for the application
  static const green = MaterialColor(0xFF8BE5AF, <int, Color>{
    // Text color
    900: Color(0xFF273E30),

    // Text Success password color
    100: Color(0xFF00A542),

    // Compatibility with the Material Design
    800: Color(0xFF273E30),
    700: Color(0xFF273E30),
    600: Color(0xFF273E30),
    500: Color(0xFF273E30),
    400: Color(0xFF00A542),
    300: Color(0xFF00A542),
    200: Color(0xFF00A542),
    150: Color(0xFF00A542),
    50: Color(0xFF00A542),
  });

  /// Defines shades of the red color for the application.
  static const red = MaterialColor(0xFFCC0131, <int, Color>{
    // Danger Text color
    900: Color(0xFF520013),

    // Danger Background color
    100: Color(0xFFFF99AC),

    // Compatibility with the Material Design
    800: Color(0xFF520013),
    700: Color(0xFF520013),
    600: Color(0xFF520013),
    500: Color(0xFFCC0131),
    400: Color(0xFFCC0131),
    300: Color(0xFFCC0131),
    200: Color(0xFFFF7991),
    150: Color(0xFFFF7991),
    50: Color(0xFFFF7991),
  });

  /// Defines shades of the brown color for the application.
  static const brown = MaterialColor(0xFF4F2F03, <int, Color>{
    // Compatibility with the Material Design
    900: Color(0xFF4F2F03),
    800: Color(0xFF4F2F03),
    700: Color(0xFF4F2F03),
    600: Color(0xFF4F2F03),
    500: Color(0xFF4F2F03),
    400: Color(0xFF4F2F03),
    300: Color(0xFF4F2F03),
    200: Color(0xFF4F2F03),
    150: Color(0xFF4F2F03),
    100: Color(0xFF4F2F03),
    50: Color(0xFF4F2F03),
  });

  /// Defines shades of the orange color for the application.
  static const orange = MaterialColor(0xFFFEA832, <int, Color>{
    // Compatibility with the Material Design
    900: Color(0xFFFEA832),
    800: Color(0xFFFEA832),
    700: Color(0xFFFEA832),
    600: Color(0xFFFEA832),
    500: Color(0xFFFEA832),
    400: Color(0xFFFEA832),
    300: Color(0xFFFEA832),
    200: Color(0xFFFEA832),
    150: Color(0xFFFEA832),
    100: Color(0xFFFEA832),
    50: Color(0xFFFEA832),
  });

  static const Color ochre = Color(0XFFFF9A00);

  static const Color orangePeel = Color(0XFFFE9800);
}
