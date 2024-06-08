import 'package:flutter/material.dart';

import '../gain_control/gain_indicator.dart';
import 'oscillogram_paint.dart';

class OscillogramView extends StatelessWidget {
  const OscillogramView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Stack(
        children: [
          OscillogramPaint(),
          GainIndicator(),
        ],
      ),
    );
  }
}
