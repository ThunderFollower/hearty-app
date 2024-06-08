import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../guide/views/common/guide_tile.dart';
import '../../views.dart';
import 'index.dart';

class YoutubeWidget extends ConsumerWidget {
  const YoutubeWidget({
    super.key,
    this.videoId,
    this.imageToScreenHeightQuotient = GuideTile.imageToScreenHeightQuotient,
  });

  final String? videoId;
  final double imageToScreenHeightQuotient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height / imageToScreenHeightQuotient;
    final width = height * _frameImageAspectRatio;

    final id = videoId;
    final content = id != null
        ? _Content(videoId: id, width: width)
        : _Loader(width: width);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [SvgPicture.asset(_deviceAssetPath), content],
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.shadow;

    final stack = Stack(
      alignment: AlignmentDirectional.center,
      children: [Container(color: color), const Loader()],
    );

    return Container(width: width, padding: _padding, child: stack);
  }
}

class _Content extends ConsumerWidget {
  const _Content({
    required this.videoId,
    required this.width,
  });

  final String videoId;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateProvider = youtubeStateProvider(videoId);
    final state = ref.watch(stateProvider);
    final controller = ref.watch(stateProvider.notifier);

    final theme = Theme.of(context);
    final overlayColor = theme.colorScheme.shadow;
    final progressIndicatorColor = theme.colorScheme.primaryContainer;

    final youtubePlayer = YoutubePlayer(
      aspectRatio: _iphone14AspectRatio,
      controller: controller.playingController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: progressIndicatorColor,
    );
    final youtubePlayerBuilder = YoutubePlayerBuilder(
      player: youtubePlayer,
      builder: (_, player) => player,
    );
    final gestureDetector = GestureDetector(
      onTap: state.processingState == YoutubeProcessingState.playing
          ? controller.pause
          : null,
    );
    final videoStack = Stack(
      alignment: AlignmentDirectional.center,
      children: [
        youtubePlayerBuilder,
        if (state.processingState == YoutubeProcessingState.loading)
          const Loader(),
        if (state.processingState == YoutubeProcessingState.paused) ...[
          Container(color: overlayColor),
          _PlayButton(onPressed: controller.play),
        ],
        gestureDetector,
      ],
    );

    return Container(width: width, padding: _padding, child: videoStack);
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final playIconColor = theme.colorScheme.primaryContainer;
    final playButtonColor = theme.colorScheme.secondary;
    final icon = Icon(
      AppIcons.play,
      color: playIconColor,
      size: middleIndent,
      semanticLabel: 'play_btn',
    );
    const circleBorder = CircleBorder();
    final styleFrom = ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      backgroundColor: playButtonColor,
      fixedSize: _playButtonSize,
      elevation: 0,
      shape: circleBorder,
    );

    return ElevatedButton(onPressed: onPressed, style: styleFrom, child: icon);
  }
}

const _frameImageAspectRatio = 0.57;
const _iphone14AspectRatio = 9 / 19.5;
const _deviceAssetPath = 'assets/guides/device.svg';
const _padding = EdgeInsets.only(
  left: lowestIndent,
  right: lowestIndent,
  top: middleIndent,
);
const _playButtonSize = Size(56, 56);
