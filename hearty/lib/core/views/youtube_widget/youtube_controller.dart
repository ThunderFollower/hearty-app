import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'youtube_state.dart';

abstract class YoutubeController extends StateNotifier<YoutubeState> {
  YoutubeController(super.state);

  YoutubePlayerController get playingController;

  void play();
  void pause();
}
