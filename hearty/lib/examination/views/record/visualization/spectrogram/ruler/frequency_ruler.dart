import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../core/views.dart';
import '../../../../../../../../../generated/locale_keys.g.dart';

class FrequencyRuler extends StatelessWidget {
  const FrequencyRuler({
    super.key,
    required this.height,
    required this.bottomFrequency,
    required this.topFrequency,
  })  : pixelPerHz = height / (topFrequency - bottomFrequency),
        topLeftover = topFrequency % markPerHz,
        bottomLeftover = bottomFrequency % markPerHz == 0
            ? 0
            : markPerHz - bottomFrequency % markPerHz;

  static const int markPerHz = 10;
  static const int labelPerHz = 50;
  static const markWidth = 8.0;
  static const fontSize = 10.0;
  final double height;
  final int bottomFrequency;
  final int topFrequency;
  final double pixelPerHz;
  final int topLeftover;
  final int bottomLeftover;

  @override
  Widget build(BuildContext context) {
    final frequencyRange =
        topFrequency - bottomFrequency - topLeftover - bottomLeftover;
    final frequencyMarksCount = frequencyRange ~/ markPerHz + 1;
    final frequencyLabelCount = frequencyRange ~/ labelPerHz + 1;
    return Positioned(
      top: 0,
      left: 0,
      child: Row(
        children: [
          SizedBox(
            width: markWidth,
            height: height,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              reverse: true,
              padding: EdgeInsets.only(
                top: topLeftover * pixelPerHz,
                bottom: bottomLeftover * pixelPerHz,
              ),
              separatorBuilder: (context, index) {
                final separatorHeight = markPerHz * pixelPerHz - 1;
                return SizedBox(
                  height: separatorHeight > 1 ? separatorHeight : 1,
                );
              },
              itemBuilder: (_, int index) {
                return Divider(
                  endIndent: computeMarkEndIdent(index),
                  height: 1,
                  thickness: 1,
                  color: AppColors.grey[900],
                );
              },
              itemCount: frequencyMarksCount,
            ),
          ),
          const SizedBox(width: 2),
          SizedBox(
            width: 50,
            height: height,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              reverse: true,
              padding: EdgeInsets.zero,
              itemBuilder: (_, int index) => Container(
                alignment: Alignment.topLeft,
                height: computeLabelHeight(index, bottomLeftover),
                child: Text(
                  buildLabelText(index),
                  style: TextStyle(
                    fontSize: fontSize,
                    height: 0.9,
                    color: AppColors.grey[900],
                  ),
                ),
              ),
              itemCount: frequencyLabelCount,
            ),
          ),
        ],
      ),
    );
  }

  double computeMarkEndIdent(int index) =>
      (bottomFrequency + bottomLeftover + index * markPerHz) % labelPerHz == 0
          ? 0
          : markWidth / 2;

  double computeLabelHeight(int index, int bottomLeftover) => index == 0
      ? (labelPerHz - bottomFrequency % labelPerHz) * pixelPerHz +
          fontSize / 2 -
          1
      : labelPerHz * pixelPerHz;

  String buildLabelText(int index) {
    final correctedIndex = index + (bottomFrequency % labelPerHz == 0 ? 1 : 0);
    final currentIndex = correctedIndex + (bottomFrequency / labelPerHz).ceil();
    return '${currentIndex * labelPerHz} ${LocaleKeys.Hz.tr()}';
  }
}
