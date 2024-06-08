import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Widget to consume local images depending on the file
/// extension (.svg, .png, .jpeg and etc)
class LocalImage extends StatelessWidget {
  const LocalImage({
    required this.assetPath,
    this.color,
    this.width,
    this.height,
  });

  final String assetPath;
  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) => assetPath.endsWith(_svgExtension)
      ? SvgPicture.asset(
          assetPath,
          colorFilter: _getColorFilter(),
          width: width,
          height: height,
        )
      : Image.asset(
          assetPath,
          color: color,
          width: width,
          height: height,
        );

  ColorFilter? _getColorFilter() =>
      color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null;
}

const _svgExtension = '.svg';
