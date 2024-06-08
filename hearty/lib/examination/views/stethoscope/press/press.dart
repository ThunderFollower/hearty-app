import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/views/theme/indentation_constants.dart';
import '../../../../generated/locale_keys.g.dart';
import '../providers.dart';
import '../stethoscope_controller.dart';

class Press extends ConsumerStatefulWidget {
  const Press({super.key});

  @override
  ConsumerState<Press> createState() => _PressState();
}

class _PressState extends ConsumerState<Press>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 1.5;
    final isRecording = RecordingStates.recording ==
        ref.watch(
          stethoscopeStateProvider
              .select((value) => value.recordingState.state),
        );
    final text = isRecording
        ? '${LocaleKeys.Continue_pressing.tr()}...'
        : LocaleKeys.Press_to_body.tr();

    final theme = Theme.of(context);
    final mainColor = theme.colorScheme.onSurface;
    final textStyle = theme.textTheme.headlineMedium?.copyWith(
      color: mainColor,
    );
    return Column(
      children: [
        SizedBox(
          width: width,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(text, style: textStyle),
          ),
        ),
        wrap(
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: _controller.value * 10,
                child: SvgPicture.asset(
                  'assets/images/arrow_down.svg',
                  colorFilter: ColorFilter.mode(mainColor, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget wrap(Widget widget) => SizedBox(
        height: veryHighIndent,
        child: RepaintBoundary(child: widget),
      );
}
