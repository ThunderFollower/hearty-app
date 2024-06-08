import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/views/local_image/local_image.dart';
import '../../../../../../../core/views/theme/indentation_constants.dart';

import '../../../../../../record/organ_type.dart';

class InspectionContent extends StatelessWidget {
  const InspectionContent({
    this.createdAt,
    this.heartRate,
    this.isFine = false,
    this.hasMurmur = false,
    this.organ,
    this.onTap,
  });

  final DateTime? createdAt;
  final int? heartRate;
  final bool isFine;
  final bool hasMurmur;
  final OrganType? organ;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.primary.withOpacity(0.3);

    final boxDecoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: _borderRadius,
    );
    final container = Container(
      padding: _innerPadding,
      decoration: boxDecoration,
      child: _buildContent(theme),
    );
    return Padding(padding: _externalPadding, child: container);
  }

  Widget _buildContent(ThemeData theme) => Column(
        children: [
          _buildHeader(theme),
        ],
      );

  Widget _buildHeader(ThemeData theme) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (createdAt != null) _buildDate(theme),
          if (heartRate != null) _buildHeartRate(theme),
        ],
      );

  Widget _buildDate(ThemeData theme) {
    assert(createdAt != null);
    final color = theme.colorScheme.onPrimaryContainer;
    final textStyle = theme.textTheme.bodySmall?.copyWith(color: color);
    return Row(
      children: [
        const SizedBox(width: _smallestIndent),
        Text(_formatDate(), style: textStyle),
      ],
    );
  }

  String _formatDate() {
    final localDate = (createdAt ?? DateTime.now()).toLocal();
    return DateFormat.yMMMd().add_jm().format(localDate);
  }

  Widget _buildHeartRate(ThemeData theme) {
    final color = theme.colorScheme.onSurface;
    final textStyle = theme.textTheme.labelMedium?.copyWith(color: color);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const LocalImage(assetPath: _heartRateIconPath),
        const SizedBox(width: _smallestIndent),
        Text('$heartRate', style: textStyle),
      ],
    );
  }
}

const _innerPadding = EdgeInsets.symmetric(
  horizontal: belowLowIndent,
  vertical: lowIndent,
);
const _externalPadding = EdgeInsets.symmetric(
  horizontal: middleIndent,
  vertical: lowestIndent,
);
const _borderRadius = BorderRadius.all(Radius.circular(lowIndent));
const _smallestIndent = 4.0;

const _heartRateIconPath = 'assets/images/heart_rate.svg';
const _neutralAttentionIconPath = 'assets/images/neutral_attention.svg';
const _redAttentionIconPath = 'assets/images/red_attention.svg';
const _warningIconPath = 'assets/images/attention.svg';
