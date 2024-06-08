import 'youtube_processing_state.dart';

class YoutubeState {
  const YoutubeState({
    this.processingState = YoutubeProcessingState.loading,
  });

  final YoutubeProcessingState processingState;

  YoutubeState copyWith({
    YoutubeProcessingState? processingState,
  }) =>
      YoutubeState(
        processingState: processingState ?? this.processingState,
      );
}
