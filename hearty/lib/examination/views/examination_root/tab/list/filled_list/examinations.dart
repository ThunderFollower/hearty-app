import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../utils/utils.dart';
import '../../../../../../core/views.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../examination.dart';
import '../../../examination_list_controller.dart';
import 'tile/examination_tile.dart';

class Examinations extends ConsumerWidget {
  const Examinations();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(examinationListController);

    final list = listState.examinations!.toList(growable: false);
    list.sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));

    return RefreshIndicator(
      color: Colors.pink,
      onRefresh: ref.read(examinationListController.notifier).refresh,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: listState.scrollController,
        itemCount: list.length + (listState.isLoadingMore ? 1 : 0),
        itemBuilder: (_, i) {
          if (listState.isLoadingMore && i == list.length) {
            return const Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              ),
            );
          }
          return i == 0
              ? _TileWithLabel(modifiedAt: list[i].modifiedAt, id: list[i].id)
              : _Tile(id: list[i].id);
        },
        separatorBuilder: (BuildContext context, int i) {
          return isLabelNeeded(i, list)
              ? _DateLabel(date: list[i + 1].modifiedAt)
              : const SizedBox(height: 8);
        },
      ),
    );
  }

  bool isLabelNeeded(int i, List<ExaminationShort> exams) {
    final currentDate = exams[i].modifiedAt;
    final nextDate = i == exams.length - 1 ? null : exams[i + 1].modifiedAt;
    final sameNextDay = nextDate != null && currentDate.isSameDayWith(nextDate);
    final sameNextMonth =
        nextDate != null && currentDate.isSameMonthWith(nextDate);
    return nextDate != null &&
        (((currentDate.isToday || currentDate.isYesterday) && !sameNextDay) ||
            !sameNextMonth);
  }
}

class _Tile extends StatefulWidget {
  const _Tile({required this.id});

  final String id;

  @override
  State<_Tile> createState() => _TileState();
}

class _TileState extends State<_Tile> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExaminationTile(examinationId: widget.id);
  }

  @override
  bool get wantKeepAlive => true;
}

class _TileWithLabel extends StatefulWidget {
  const _TileWithLabel({required this.id, required this.modifiedAt});

  final DateTime modifiedAt;
  final String id;

  @override
  State<_TileWithLabel> createState() => _TileWithLabelState();
}

class _TileWithLabelState extends State<_TileWithLabel>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DateLabel(date: widget.modifiedAt),
        ExaminationTile(examinationId: widget.id),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({required this.date});

  static final formatter = DateFormat.MMMM();
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const padding = EdgeInsets.fromLTRB(
      highIndent,
      aboveLowestIndent,
      middleIndent,
      aboveLowestIndent,
    );
    final data = _formatDate();
    final color = theme.colorScheme.secondaryContainer;
    final style = theme.textTheme.bodySmall?.copyWith(color: color);
    final text = Text(data, style: style);
    return Padding(padding: padding, child: text);
  }

  String _formatDate() {
    String label;
    if (date.isToday) {
      label = LocaleKeys.TODAY.tr();
    } else if (date.isYesterday) {
      label = LocaleKeys.YESTERDAY.tr();
    } else {
      label = formatter.format(date).toUpperCase();
    }

    return label;
  }
}
