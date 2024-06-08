import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../youtube_controller.dart';
import '../youtube_controller_adapter.dart';
import '../youtube_state.dart';

final youtubeStateProvider = StateNotifierProvider.autoDispose
    .family<YoutubeController, YoutubeState, String>(
  (_, videoId) {
    const flags = YoutubePlayerFlags(
      autoPlay: false,
      loop: true,
      forceHD: true,
      hideControls: true,
    );
    final controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: flags,
    );

    return YoutubeControllerAdapter(controller);
  },
);
