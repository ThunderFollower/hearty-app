import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/views.dart';

/// Represents a skeleton placeholder for the Inspection view.
///
/// The [InspectionSkeleton] is split into three sections:
/// - Header: Indicated by [_InspectionSkeletonHeader]
/// - Content: Indicated by [_InspectionSkeletonContent]
/// - Footer: Indicated by [_InspectionSkeletonFooter]
class InspectionSkeleton extends StatelessWidget {
  const InspectionSkeleton();

  @override
  Widget build(BuildContext context) => const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _InspectionSkeletonHeader(),
          _InspectionSkeletonContent(),
          _InspectionSkeletonFooter(),
        ],
      );
}

class _InspectionSkeletonHeader extends StatelessWidget {
  const _InspectionSkeletonHeader();

  static const style = SkeletonLineStyle(
    width: 204,
    height: 20,
    alignment: Alignment.center,
    padding: EdgeInsets.all(14),
  );

  @override
  Widget build(BuildContext context) => const SkeletonLine(style: style);
}

class _InspectionSkeletonContent extends StatelessWidget {
  const _InspectionSkeletonContent();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final scale = mediaQuery.size.width / standardUiSize.width;

    final style = SkeletonLineStyle(
      width: 342 * scale,
      height: 64,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: middleIndent,
        vertical: lowestIndent,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(lowIndent)),
    );

    return SkeletonLine(style: style);
  }
}

class _InspectionSkeletonFooter extends StatelessWidget {
  const _InspectionSkeletonFooter();
  static const style = SkeletonAvatarStyle(
    width: 56,
    height: 56,
    shape: BoxShape.circle,
  );

  @override
  Widget build(BuildContext context) => const SkeletonAvatar(style: style);
}
