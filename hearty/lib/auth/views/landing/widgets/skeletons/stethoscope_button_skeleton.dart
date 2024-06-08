import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

/// The width of the stethoscope button.
const _width = 88.0;

/// The height of the stethoscope button.
const _height = 46.0;

/// A placeholder widget that represents a loading state for the Stethophone Button.
///
/// This widget displays a skeleton while the stethoscope functionality
/// is loading or initializing.
class StethophoneButtonSkeleton extends StatelessWidget {
  const StethophoneButtonSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SkeletonAvatar(
      style: SkeletonAvatarStyle(width: _width, height: _height),
    );
  }
}
