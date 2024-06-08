import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/views.dart';
import 'controller/providers.dart';
import 'header/record_header.dart';
import 'playback_controls/playback_controls.dart';
import 'visualization/segmented_visualization.dart';

part 'record_page_body.dart';
part 'record_page_control_panel.dart';
part 'record_page_header.dart';
part 'record_page_layout.dart';

/// A widget representing an existing record.
@RoutePage()
class RecordPage extends ConsumerWidget {
  /// Constructs an [RecordPage].
  ///
  /// The [recordId] parameter is the record associated with this widget.
  const RecordPage({
    @PathParam(recordIdParam) required this.recordId,
    @QueryParam(mutableParam) this.mutable = true,
  });

  // The record associated with this widget.
  final String recordId;

  /// If mutable is true, deleting or updating audio is granted.
  /// Otherwise, it's prohibited.
  final bool mutable;

  @override
  Widget build(BuildContext context, WidgetRef ref) => _Layout(
        children: [
          _Header(recordId, mutable: mutable),
          Expanded(child: _Body(recordId)),
          _ControlPanel(recordId),
        ],
      );
}
