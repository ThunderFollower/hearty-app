import 'package:flutter/material.dart';
import '../../../../../core/views/button/round_filled_button/round_filled_button.dart';
import '../../../../../core/views/theme/app_gradients.dart';
import 'countdown/countdown_arch.dart';

class DoctorRecordButton extends StatelessWidget {
  const DoctorRecordButton({
    super.key,
    required this.totalTime,
    this.onPressed,
    this.nameId = 'doctor_record_button',
  });

  final VoidCallback? onPressed;
  final int totalTime;
  final String nameId;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          CountdownArch(
            strokeWidth: _inactiveStrokeWidth,
            totalTime: totalTime,
            timeLeft: totalTime,
          ),
          _Button(nameId: nameId, onPressed: onPressed),
        ],
      );
}

class _Button extends StatelessWidget {
  const _Button({
    required this.nameId,
    required this.onPressed,
  });

  final String nameId;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final button = RoundFilledButton(
      id: nameId,
      size: _filledPartWidth,
      onPressed: onPressed,
      color: Colors.transparent,
      child: const SizedBox.shrink(),
    );

    return DecoratedBox(decoration: _decoration, child: button);
  }
}

const _filledPartWidth = 54.0;
const _inactiveStrokeWidth = 2.0;
const _decoration = BoxDecoration(
  shape: BoxShape.circle,
  gradient: AppGradients.red,
);
