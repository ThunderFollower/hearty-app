import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/views.dart';
import '../../../../../../../../generated/locale_keys.g.dart';

class FindingLabelWidget extends StatelessWidget {
  const FindingLabelWidget({
    this.hasMurmur,
    this.isFine,
  });

  /// Indicates if the record has a murmur.
  final bool? hasMurmur;

  /// Indicates if the record is fine.
  final bool? isFine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isFine != null && hasMurmur != null) {
      return _buildLabel(theme, hasMurmur!, isFine!);
    }

    return const SizedBox.shrink();
  }

  Widget _buildLabel(ThemeData theme, bool hasMurmur, bool isFine) {
    final textStyle = theme.textTheme.bodyLarge;
    final colorScheme = theme.colorScheme;

    if (hasMurmur) {
      final chipColor = colorScheme.errorContainer.withOpacity(0.5);
      final textColor = colorScheme.onErrorContainer;
      return _buildChip(
        chipColor,
        _redAttentionIconPath,
        LocaleKeys.Murmur_detected.tr(),
        textStyle?.copyWith(color: textColor),
        key: _chipWithMurmurKey,
      );
    } else if (!isFine) {
      final chipColor = colorScheme.surface.withOpacity(0.2);
      final textColor = colorScheme.onErrorContainer;
      return _buildChip(
        chipColor,
        _warningIconPath,
        LocaleKeys.InsufficientQuality_regularName.tr(),
        textStyle?.copyWith(color: textColor),
        key: _chipLowQualityKey,
      );
    }

    final chipColor = colorScheme.primary;
    final textColor = colorScheme.onPrimaryContainer;
    return _buildChip(
      chipColor,
      _neutralAttentionIconPath,
      LocaleKeys.Murmur_not_detected.tr(),
      textStyle?.copyWith(color: textColor),
      key: _chipNoMurmurKey,
    );
  }

  Widget _buildChip(
    Color chipColor,
    String assetPath,
    String text,
    TextStyle? style, {
    Key? key,
  }) {
    final row = Row(
      children: [
        SizedBox(
          width: lowIndent,
          height: lowIndent,
          child: LocalImage(assetPath: assetPath),
        ),
        const SizedBox(width: _tinyIndent),
        Text(key: _chipText, text, style: style),
      ],
    );

    return Chip(
      labelPadding: EdgeInsets.zero,
      padding: _chipInnerPadding,
      backgroundColor: chipColor,
      label: row,
      key: key,
    );
  }
}

const _neutralAttentionIconPath = 'assets/images/neutral_attention.svg';
const _redAttentionIconPath = 'assets/images/red_attention.svg';
const _warningIconPath = 'assets/images/attention.svg';
const _smallIndent = 6.0;
const _tinyIndent = 4.0;
const _chipInnerPadding = EdgeInsets.symmetric(
  vertical: _smallIndent,
  horizontal: belowLowIndent,
);

// Keys
const _chipNoMurmurKey = Key('chip_no_murmur');
const _chipWithMurmurKey = Key('chip_with_murmur');
const _chipLowQualityKey = Key('chip_low_quality');
const _chipText = Key('chip_text');
