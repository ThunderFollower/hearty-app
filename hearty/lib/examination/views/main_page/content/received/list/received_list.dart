import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../utils/utils.dart';
import '../../../../../../../core/views.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../examination/entities/examination_short.dart';
import '../../../../examination_root/tab/list/filled_list/tile/examination_tile.dart';
import 'received_list_controller.dart';

class ReceivedList extends ConsumerWidget {
  const ReceivedList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_stateProvider);
    final controller = ref.watch(_stateProvider.notifier);

    final examinations = state.examinations?.toList(growable: false);
    examinations?.sort(_compareElements);

    final itemCount = _totalItemCount(examinations, state.isLoadingMore);
    final itemBuilder = _buildItemBuilder(examinations, state.isLoadingMore);
    final separatorBuilder = _buildSeparatorBuilder(examinations);

    final listView = ListView.separated(
      physics: _bouncingScrollPhysics,
      controller: state.scrollController,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: separatorBuilder,
    );

    final refreshIndicator = RefreshIndicator(
      onRefresh: controller.refresh,
      child: listView,
    );
    return refreshIndicator;
  }

  int _totalItemCount(
    List<ExaminationShort>? examinations,
    bool isLoadingMore,
  ) {
    final extra = isLoadingMore ? 1 : 0;
    final length = examinations?.length ?? 0;
    return extra + length;
  }

  IndexedWidgetBuilder _buildItemBuilder(
    List<ExaminationShort>? examinations,
    bool isLoadingMore,
  ) =>
      (_, int index) {
        if (examinations == null ||
            index >= examinations.length ||
            _shouldShowFooter(examinations, index, isLoadingMore)) {
          return const _FooterItemView();
        }

        final element = examinations.elementAt(index);
        if (index == 0) return _HeaderItemView(element: element);
        return _Tile(id: element.id);
      };

  IndexedWidgetBuilder _buildSeparatorBuilder(
    List<ExaminationShort>? examinations,
  ) =>
      (BuildContext context, int index) {
        final date = _separatorDate(index, examinations);
        if (date == null) {
          return const SizedBox(height: lowestIndent);
        }
        return _DateLabel(date: date);
      };

  bool _shouldShowFooter(
    List<ExaminationShort>? examinations,
    int index,
    bool isLoadingMore,
  ) =>
      isLoadingMore && index == examinations?.length;

  int _compareElements(ExaminationShort left, ExaminationShort right) =>
      right.modifiedAt.compareTo(left.modifiedAt);

  DateTime? _separatorDate(
    int index,
    Iterable<ExaminationShort>? examinations,
  ) {
    final nextIndex = index + 1;
    if (examinations == null || examinations.length <= nextIndex) return null;

    final currentDate = examinations.elementAt(index).modifiedAt;
    final nextDate = examinations.elementAt(nextIndex).modifiedAt;
    final sameNextDay = currentDate.isSameDayWith(nextDate);
    final sameNextMonth = currentDate.isSameMonthWith(nextDate);

    final isTodayOrYesterday = currentDate.isToday || currentDate.isYesterday;

    if (isTodayOrYesterday && !sameNextDay || !sameNextMonth) return nextDate;

    return null;
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
    return ExaminationTile(examinationId: widget.id, received: true);
  }

  @override
  bool get wantKeepAlive => true;
}

class _HeaderItemView extends StatefulWidget {
  const _HeaderItemView({
    required this.element,
  });

  final ExaminationShort element;

  @override
  State<_HeaderItemView> createState() => _HeaderItemViewState();
}

class _HeaderItemViewState extends State<_HeaderItemView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final label = _DateLabel(date: widget.element.modifiedAt);
    final item = ExaminationTile(
      examinationId: widget.element.id,
      received: true,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [label, item],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _FooterItemView extends StatelessWidget {
  const _FooterItemView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final indicator = CircularProgressIndicator(color: colorScheme.secondary);
    final center = Center(child: indicator);
    const padding = EdgeInsets.all(lowestIndent);
    return Padding(padding: padding, child: center);
  }
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

/// Alias to the state provider.
final _stateProvider = receivedListStateProvider;

const _bouncingScrollPhysics = BouncingScrollPhysics(
  parent: AlwaysScrollableScrollPhysics(),
);
