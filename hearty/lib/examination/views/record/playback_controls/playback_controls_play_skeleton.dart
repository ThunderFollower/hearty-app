part of 'playback_controls.dart';

class _PlayButtonSkeleton extends StatelessWidget {
  const _PlayButtonSkeleton();

  @override
  Widget build(BuildContext context) => SkeletonAvatar(
        style: SkeletonAvatarStyle(
          width: _playButtonSize.width,
          height: _playButtonSize.height,
          shape: BoxShape.circle,
        ),
      );
}
