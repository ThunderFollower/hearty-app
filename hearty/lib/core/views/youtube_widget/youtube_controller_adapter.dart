import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'youtube_controller.dart';
import 'youtube_processing_state.dart';
import 'youtube_state.dart';

class YoutubeControllerAdapter extends YoutubeController {
  YoutubeControllerAdapter(this._controller) : super(const YoutubeState()) {
    _controller.addListener(_stateListener);
  }

  final YoutubePlayerController _controller;

  @override
  YoutubePlayerController get playingController => _controller;

  @override
  void pause() => _controller.pause();

  @override
  void play() => _controller.play();

  void _stateListener() {
    final value = _controller.value;

    if (!value.isReady) {
      state = state.copyWith(processingState: YoutubeProcessingState.loading);
    } else if (value.isPlaying) {
      state = state.copyWith(processingState: YoutubeProcessingState.playing);
    } else if (!value.isPlaying) {
      state = state.copyWith(processingState: YoutubeProcessingState.paused);
    } else {
      state = state.copyWith(processingState: YoutubeProcessingState.error);
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_stateListener)
      ..dispose();
    super.dispose();
  }
}
