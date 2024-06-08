import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../../../../core/views.dart';
import '../../../examination.dart';
import '../../common/common.dart';

part 'record_header_timestamp.dart';
part 'record_header_title_skeleton.dart';

const _titlePadding = EdgeInsets.symmetric(horizontal: lowIndent);

/// A widget representing the header of an existing record.
class RecordHeader extends StatelessWidget {
  /// Constructs an [RecordHeader].
  ///
  /// The [recordId] parameter is the record associated with this header.
  ///
  /// The [spot] parameter represents a specific point in the record.
  ///
  /// The [mutable] parameter specifies whether the record is mutable or not.
  /// It is set to `true` by default.
  const RecordHeader({
    super.key,
    this.mutable = true,
    this.onDelete,
    this.onRecordAgain,
    this.onBack,
    this.spot,
    this.recordId,
    this.name,
    this.createdAt,
  });

  final VoidCallback? onDelete;
  final VoidCallback? onRecordAgain;
  final VoidCallback? onBack;

  /// If mutable is true, deleting or updating audio is granted.
  /// Otherwise, it's prohibited.
  final bool mutable;

  final Spot? spot;
  final String? recordId;
  final String? name;
  final DateTime? createdAt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          key: _backButtonKey,
          icon: const Icon(AppIcons.back),
          onPressed: onBack,
        ),
        buildMenu(),
      ],
    );
    final padding = Padding(padding: _titlePadding, child: row);

    return Column(children: [padding, _buildRecordDateText(theme)]);
  }

  @protected
  Widget buildMenu() {
    if (!mutable) return const SizedBox(width: _menuButtonWidth);

    if (recordId == null || spot == null) return MenuButtonSkeleton();

    return RecordContextMenuButton(
      recordId: recordId!,
      spot: spot!,
      onDelete: onDelete,
      onRecordAgain: onRecordAgain,
    );
  }

  Widget _buildRecordDateText(ThemeData theme) =>
      _Timestamp(createdAt: createdAt);
}

const _menuButtonWidth = 56.0;
// Keys
const _backButtonKey = Key('back_button_key');
