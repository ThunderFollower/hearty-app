import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/views/theme/indentation_constants.dart';
import '../../../../../../../generated/locale_keys.g.dart';
import '../../../../../../examination.dart';
import '../../../../../common/common.dart';

/// A widget representing the header of an existing record.
class InspectionHeader extends StatelessWidget {
  /// Constructs an [InspectionHeader].
  ///
  /// The [mutable] parameter specifies whether the record is mutable or not.
  /// It is set to `true` by default.

  const InspectionHeader({
    this.mutable = true,
    Spot? spot,
    required this.recordId,
    this.name,
    this.onDelete,
    this.onRecordAgain,
  }) : spot = spot ?? Spot.erbs;

  final String recordId;
  final String? name;

  /// If mutable is true, deleting or updating audio is granted.
  /// Otherwise, it's prohibited.
  final bool mutable;

  final Spot spot;

  final VoidCallback? onDelete;
  final VoidCallback? onRecordAgain;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: extremelyHightIndent),
        _buildExpandableLayout(theme),
        if (mutable) _buildContextMenu(),
      ],
    );
  }

  Widget _buildContextMenu() => RecordContextMenuButton(
        recordId: recordId,
        spot: spot,
        onDelete: onDelete,
        onRecordAgain: onRecordAgain,
      );

  Widget _buildExpandableLayout(ThemeData theme) {
    final richText = _buildRichText(theme);
    final fittedBox = FittedBox(fit: BoxFit.scaleDown, child: richText);
    return Expanded(child: fittedBox);
  }

  Widget _buildRichText(ThemeData theme) {
    final spotTextStyle = theme.textTheme.titleLarge;
    final spotColor = theme.colorScheme.onPrimary;
    final spotNameTextStyle = spotTextStyle?.copyWith(color: spotColor);
    final spotName = _buildSpotNameText(spotNameTextStyle);

    return RichText(
      key: _bodySpotBottomSheetKey,
      maxLines: _maxLines,
      softWrap: false,
      textAlign: TextAlign.center,
      textScaleFactor: _textScaleFactor,
      text: spotName,
    );
  }

  TextSpan _buildSpotNameText(TextStyle? spotNameTextStyle) => TextSpan(
        text: LocaleKeys.To_listen_connect_Bluetooth_headphones.tr(),
        style: spotNameTextStyle,
      );
}

const _textScaleFactor = 1.1;
const _maxLines = 1;

// Keys
const _bodySpotBottomSheetKey = Key('body_spot_bottom_sheet_header_key');
