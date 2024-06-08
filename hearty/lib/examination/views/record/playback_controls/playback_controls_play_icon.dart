part of 'playback_controls.dart';

class _PlayButtonIcon extends StatelessWidget {
  const _PlayButtonIcon({
    super.key,
    required this.isPlaying,
  });

  final bool? isPlaying;

  @override
  Widget build(BuildContext context) => Icon(
        isPlaying == true ? AppIcons.pause : AppIcons.play,
        color: Colors.white,
        size: _iconSize,
        semanticLabel: 'play_pause_btn',
      );
}
