part of 'playback_controls.dart';

class _FilterButtonSkeleton extends StatelessWidget {
  const _FilterButtonSkeleton();

  @override
  Widget build(BuildContext context) => const SkeletonAvatar(
        style: SkeletonAvatarStyle(width: 64.0, height: 56.0),
      );
}
