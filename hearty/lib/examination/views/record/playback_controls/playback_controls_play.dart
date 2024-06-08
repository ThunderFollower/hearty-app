part of 'playback_controls.dart';

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    required this.onPlay,
    required this.isPlaying,
  });

  final VoidCallback? onPlay;
  final bool? isPlaying;

  @override
  Widget build(BuildContext context) {
    if (onPlay == null || isPlaying == null) {
      return const _PlayButtonSkeleton();
    }
    final style = ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      fixedSize: _playButtonSize,
      elevation: 0,
      shape: const CircleBorder(),
    );

    return ElevatedButton(
      key: const Key('play_button'),
      onPressed: onPlay,
      style: style,
      child: _PlayButtonIcon(
        key: Key('Playing: $isPlaying'),
        isPlaying: isPlaying,
      ),
    );
  }
}
